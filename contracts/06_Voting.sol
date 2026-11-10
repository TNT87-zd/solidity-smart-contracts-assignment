// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate { string name; uint256 voteCount; }
    struct Voter { bool authorized; bool voted; uint256 voteIndex; }

    Candidate[] public candidates;
    mapping(address => Voter) public voters;
    address public chairperson;

    modifier onlyChairperson() {
        require(msg.sender == chairperson, "Only chairperson");
        _;
    }

    constructor(string[] memory candidateNames) {
        chairperson = msg.sender;
        for (uint256 i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate(candidateNames[i], 0));
        }
    }

    function authorize(address voter) external onlyChairperson {
        require(!voters[voter].voted, "Already voted");
        voters[voter].authorized = true;
    }

    function vote(uint256 candidateIndex) external {
        Voter storage v = voters[msg.sender];
        require(v.authorized, "Not authorized");
        require(!v.voted, "Already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");
        v.voted = true;
        v.voteIndex = candidateIndex;
        candidates[candidateIndex].voteCount += 1;
    }

    function totalVotes(uint256 candidateIndex) external view returns (uint256) {
        require(candidateIndex < candidates.length, "Invalid candidate");
        return candidates[candidateIndex].voteCount;
    }

    function winnerName() external view returns (string memory) {
        require(candidates.length > 0, "No candidates");
        uint256 winIdx = 0;
        for (uint256 i = 1; i < candidates.length; i++) {
            if (candidates[i].voteCount > candidates[winIdx].voteCount) winIdx = i;
        }
        return candidates[winIdx].name;
    }
}