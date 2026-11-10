// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StakingRewards {
    address payable public owner;
    uint256 public rewardRatePerSecond; // wei of reward per 1 ETH staked per second
    uint256 public totalStaked;
    uint256 public rewardPool;

    struct Stake { uint256 amount; uint256 startTime; uint256 rewardDebt; }
    mapping(address => Stake) public stakes;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor(uint256 _rate) payable {
        owner = payable(msg.sender);
        rewardRatePerSecond = _rate;
        rewardPool = msg.value; // seed the reward pool
    }

    function stake() external payable {
        require(msg.value > 0, "Amount must be > 0");
        Stake storage s = stakes[msg.sender];
        // snapshot pending reward BEFORE changing amount
        s.rewardDebt = pendingReward(msg.sender);
        s.startTime = block.timestamp;
        s.amount += msg.value;
        totalStaked += msg.value;
    }

    // dividing by 1e18 means: rate = wei of reward per 1 ETH staked per second
    // 1 ETH * 1000 * 60s / 1e18 = 60,000 wei (matches the test in the spec)
    function pendingReward(address user) public view returns (uint256) {
        Stake memory s = stakes[user];
        if (s.amount == 0) return s.rewardDebt;
        return s.rewardDebt + (s.amount * rewardRatePerSecond * (block.timestamp - s.startTime)) / 1e18;
    }

    function claimReward() external {
        uint256 reward = pendingReward(msg.sender);
        require(reward > 0, "No reward");
        require(rewardPool >= reward, "Reward pool empty");
        Stake storage s = stakes[msg.sender];
        s.rewardDebt = 0;
        s.startTime = block.timestamp;
        rewardPool -= reward;
        (bool ok, ) = payable(msg.sender).call{value: reward}("");
        require(ok, "Transfer failed");
    }

    function unstake() external {
        Stake memory s = stakes[msg.sender];
        require(s.amount > 0, "Nothing staked");
        uint256 reward = pendingReward(msg.sender);
        require(rewardPool >= reward, "Reward pool empty");
        totalStaked -= s.amount;
        rewardPool -= reward;
        delete stakes[msg.sender]; // reset before sending
        (bool ok, ) = payable(msg.sender).call{value: s.amount + reward}("");
        require(ok, "Transfer failed");
    }

    function fundRewards() external payable onlyOwner {
        rewardPool += msg.value;
    }

    function setRewardRate(uint256 _newRate) external onlyOwner {
        rewardRatePerSecond = _newRate;
    }
}