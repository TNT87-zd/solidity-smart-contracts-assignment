// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleNFT {
    string public name;
    string public symbol;
    uint256 public nextTokenId;
    uint256 public constant MAX_SUPPLY = 100;
    uint256 public mintPrice = 0.01 ether;
    address public owner;

    mapping(uint256 => address) public ownerOf;
    mapping(address => uint256) public balances;
    mapping(uint256 => address) public approvals;

    event Minted(address indexed to, uint256 indexed tokenId);
    event TransferNFT(address indexed from, address indexed to, uint256 indexed tokenId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
    }

    function mint() external payable returns (uint256) {
        require(msg.value == mintPrice, "Wrong mint price");
        require(nextTokenId < MAX_SUPPLY, "Max supply reached");
        uint256 id = nextTokenId++;
        ownerOf[id] = msg.sender;
        balances[msg.sender] += 1;
        emit Minted(msg.sender, id);
        return id;
    }

    function transferNFT(address to, uint256 tokenId) external {
        require(ownerOf[tokenId] == msg.sender, "Not token owner");
        _transfer(msg.sender, to, tokenId);
    }

    function approve(address spender, uint256 tokenId) external {
        require(ownerOf[tokenId] == msg.sender, "Not token owner");
        approvals[tokenId] = spender;
    }

    function transferFrom(address from, address to, uint256 tokenId) external {
        require(ownerOf[tokenId] == from, "From is not owner");
        require(approvals[tokenId] == msg.sender, "Not approved");
        _transfer(from, to, tokenId);
    }

    function _transfer(address from, address to, uint256 tokenId) private {
        require(to != address(0), "Invalid recipient");
        delete approvals[tokenId];
        ownerOf[tokenId] = to;
        balances[from] -= 1;
        balances[to] += 1;
        emit TransferNFT(from, to, tokenId);
    }

    function withdrawPayments() external onlyOwner {
        (bool ok, ) = payable(owner).call{value: address(this).balance}("");
        require(ok, "Transfer failed");
    }
}