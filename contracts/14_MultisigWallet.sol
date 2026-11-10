// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultisigWallet {
    address[] public owners;
    uint256 public required;

    struct Transaction { address to; uint256 value; bool executed; }
    Transaction[] public transactions;

    mapping(address => bool) public isOwner;
    mapping(uint256 => mapping(address => bool)) public confirmed;
    mapping(uint256 => uint256) public confirmCount;

    event Submission(uint256 indexed txId);
    event Confirmation(address indexed owner, uint256 indexed txId);
    event Execution(uint256 indexed txId);
    event Deposit(address indexed sender, uint256 amount);

    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not an owner");
        _;
    }

    constructor(address[] memory _owners, uint256 _required) {
        require(_required > 0 && _owners.length >= _required, "Invalid required count");
        for (uint256 i = 0; i < _owners.length; i++) {
            address o = _owners[i];
            require(o != address(0), "Zero address");
            require(!isOwner[o], "Duplicate owner");
            isOwner[o] = true;
            owners.push(o);
        }
        required = _required;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // submitting also counts as the submitter's confirmation
    function submitTransaction(address to, uint256 value) external onlyOwner {
        transactions.push(Transaction(to, value, false));
        uint256 txId = transactions.length - 1;
        emit Submission(txId);
        _confirm(txId);
    }

    function confirmTransaction(uint256 txId) external onlyOwner {
        _confirm(txId);
    }

    function _confirm(uint256 txId) private {
        require(txId < transactions.length, "Tx does not exist");
        require(!confirmed[txId][msg.sender], "Already confirmed");
        require(!transactions[txId].executed, "Already executed");
        confirmed[txId][msg.sender] = true;
        confirmCount[txId] += 1;
        emit Confirmation(msg.sender, txId);
        if (confirmCount[txId] == required) {
            _execute(txId); // auto-execute
        }
    }

    function executeTransaction(uint256 txId) external onlyOwner {
        _execute(txId);
    }

    function _execute(uint256 txId) private {
        require(txId < transactions.length, "Tx does not exist");
        Transaction storage t = transactions[txId];
        require(!t.executed, "Already executed");
        require(confirmCount[txId] >= required, "Not enough confirmations");
        t.executed = true; // effects before interaction
        (bool ok, ) = payable(t.to).call{value: t.value}("");
        require(ok, "Execution failed");
        emit Execution(txId);
    }

    function getConfirmations(uint256 txId) external view returns (uint256) {
        return confirmCount[txId];
    }
}