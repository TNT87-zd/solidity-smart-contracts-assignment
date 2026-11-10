// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    address payable public owner;
    uint256 public goal;
    uint256 public deadline;
    uint256 public raised;
    bool public claimed;
    mapping(address => uint256) public contributions;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor(uint256 _goal, uint256 _durationSeconds) {
        owner = payable(msg.sender);
        goal = _goal;
        deadline = block.timestamp + _durationSeconds;
    }

    function contribute() external payable {
        require(block.timestamp < deadline, "Campaign ended");
        require(msg.value > 0, "Amount must be > 0");
        contributions[msg.sender] += msg.value;
        raised += msg.value;
    }

    function getRemainingTime() public view returns (uint256) {
        if (block.timestamp >= deadline) return 0;
        return deadline - block.timestamp;
    }

    function claimFunds() external onlyOwner {
        require(block.timestamp >= deadline, "Campaign still running");
        require(raised >= goal, "Goal not reached");
        require(!claimed, "Already claimed");
        claimed = true;
        (bool ok, ) = owner.call{value: address(this).balance}("");
        require(ok, "Transfer failed");
    }

    function refund() external {
        require(block.timestamp >= deadline, "Campaign still running");
        require(raised < goal, "Goal was reached");
        uint256 amount = contributions[msg.sender];
        require(amount > 0, "Nothing to refund");
        contributions[msg.sender] = 0; // effects before interaction
        (bool ok, ) = payable(msg.sender).call{value: amount}("");
        require(ok, "Refund failed");
    }
}