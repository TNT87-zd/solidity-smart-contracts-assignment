// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {
    enum State { AwaitingPayment, AwaitingDelivery, Complete, Refunded, Disputed }

    address payable public buyer;
    address payable public seller;
    address payable public arbiter;
    State public state;

    modifier stateCheck(State s) {
        require(state == s, "Invalid state");
        _;
    }
    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only buyer");
        _;
    }
    modifier onlyArbiter() {
        require(msg.sender == arbiter, "Only arbiter");
        _;
    }
    modifier onlyArbiterOrSeller() {
        require(msg.sender == arbiter || msg.sender == seller, "Only arbiter or seller");
        _;
    }
    modifier onlyBuyerOrSeller() {
        require(msg.sender == buyer || msg.sender == seller, "Only buyer or seller");
        _;
    }

    constructor(address payable _seller, address payable _arbiter) payable {
        require(msg.value > 0, "Payment required");
        buyer = payable(msg.sender);
        seller = _seller;
        arbiter = _arbiter;
        state = State.AwaitingDelivery; // ETH sent at deploy = payment
    }

    function confirmDelivery() external onlyBuyer stateCheck(State.AwaitingDelivery) {
        state = State.Complete;
        _send(seller);
    }

    function refundBuyer() external onlyArbiterOrSeller stateCheck(State.AwaitingDelivery) {
        state = State.Refunded;
        _send(buyer);
    }

    function raiseDispute() external onlyBuyerOrSeller stateCheck(State.AwaitingDelivery) {
        state = State.Disputed;
    }

    function resolveToSeller() external onlyArbiter stateCheck(State.Disputed) {
        state = State.Complete;
        _send(seller);
    }

    function resolveToBuyer() external onlyArbiter stateCheck(State.Disputed) {
        state = State.Refunded;
        _send(buyer);
    }

    function _send(address payable to) private {
        (bool ok, ) = to.call{value: address(this).balance}("");
        require(ok, "Transfer failed");
    }
}