// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Victim {
    address[] public entrants;
    uint256 public constant AMOUNT = 1 ether;

    // Silly contract that allows people to pool their money
    // And the contract will send everyone's money back at some point
    function enter() public payable {
        if (msg.value == AMOUNT) {
            entrants.push(msg.sender);
        }
    }

    function sendBack() public {
        for (uint256 i = 0; i < entrants.length; i++) {
            (bool success,) = payable(entrants[i]).call{value: AMOUNT}("");
            require(success);
        }
        delete entrants;
    }
}