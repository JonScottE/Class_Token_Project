/ SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Raffle {

    address[] entries;

    constructor() {
        console.log("Deployed!");
    }

    function pickWinner() private view returns (uint) {
        uint random = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, entries)));
        uint index = random % entries.length;
        return index;
    }
    // This function stores all of the entered public addresses. From this, we will pick a winner.
   
    function enter() public payable {
        
        // If this function fails, the string provided by the second argument is sent back to the user, and the transactions are reverted. 
        
        require(msg.value >= 1 ether, "Pay 1 Ether or more to enter the raffle");
       
       // This pushes the address of the person who made the transaction to enter to the entries array
        
        entries.push(msg.sender);
        
        // Check if Bob is the fifth person who entered this Raffle
        
        if (entries.length >= 5) {
           
           // Call the pickWinner to get the winner's array index and get his address from the entries array.
           
            uint winnerIndex = pickWinner();
            address winner = entries[winnerIndex];
            console.log(winner);

            // get the prize amount from address(this).balance. This gets all of the ethereum that is assigned to the contract.

            uint256 prizeAmount = address(this).balance;

            // To send the money, we write (winner).call{value:prizeAmount}("")

            (bool success, ) = (winner).call{value: prizeAmount}(""); 
            require(success, "Failed to withdraw money from the contact");

            // delete all of the entries. This empties the array and is ready for another raffle!

            delete entries;
        }
    }


    function getLength() public view returns (uint) {
        return entries.length;
    }
}
