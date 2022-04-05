// saying I need to choose a license like "SPDX-License_identifier: Not MIT"
pragma solidity ^0.8.0;

contract funDrop {
    address public owner;  //owners address that deployed the contract, and one who will get the money collected by the contract
    address[] public backers; //array of the backers (people who sent money) for thanks or drops later

    constructor() {
        owner = msg.sender; //this gets the owners address msg contains the address of the one who calls the function
    }

    function sendMoney() public payable {  //function "sendMoney()", is open to everyone
        require(msg.value > 0, "Nothing was sent"); // it first requires that the value in the call is greater than zero, or else it says there's nothing and stops 
        backers.push(msg.sender); // adds the senders address to the "Backers" list
    }

    function getBalance() public view returns (uint256) {  // just a get balance function before ending it
        return address(this).balance;
    }


    function endFundraising() public { // this function is going to end the raiser and collect the money
        require(msg.sender == owner, "You're not the owner you silly goose"); // public function, requires msg.sender is the owner, or else silly goose
        payable(owner).transfer(address(this).balance); //Solidity "transfer" method
    }





}

/* if we want to deploy, we need another file/contract

all this from:
https://dev.to/kevinmaarek/getting-started-with-solidity-your-first-smart-contract-3mpe
more steps after included in other posts */
