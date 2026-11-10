// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery {
    address payable[] private players;
    address public manager;
    uint256 public entryFee;
    uint256 public minPlayers;

    event WinnerSelected(address indexed winner, uint256 amount);

    modifier onlyManager() {
        require(msg.sender == manager, "Only manager");
        _;
    }

    constructor(uint256 _entryFee, uint256 _minPlayers) {
        manager = msg.sender;
        entryFee = _entryFee;
        minPlayers = _minPlayers;
    }

    function enter() public payable {
        require(msg.sender != manager, "Manager cannot enter");
        require(msg.value == entryFee, "Wrong entry fee");
        players.push(payable(msg.sender));
    }

    function playersCount() public view returns (uint256) {
        return players.length;
    }

    function pickWinner() public onlyManager {
        require(players.length >= minPlayers, "Not enough players");
        // NOT safe for production: miners can influence blockhash
        uint256 index = uint256(blockhash(block.number - 1)) % players.length;
        address payable winner = players[index];
        uint256 amount = address(this).balance;
        delete players; // reset the round before sending ETH
        (bool ok, ) = winner.call{value: amount}("");
        require(ok, "Transfer failed");
        emit WinnerSelected(winner, amount);
    }
}