

pragma solidity ^0.5.0;
//Import the `ERC20` and `ERC20Detailed` contracts from OpenZeppelin. These contracts implement 
//the `ERC20` standards that we’ll use to build our funDrop contract. 
//Import these contracts by using the following code:

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
//?? import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

// Defining a contract named `funDrop` that inherits the OpenZeppelin `ERC20` and `ERC20Detailed` contracts.
contract funDrop is ERC20, ERC20Detailed /*??ERC20Mintable*/{
    address payable owner; //  add an `address payable` variable called `owner`
    modifier onlyOwner {//The following code will create an `onlyOwner` modifier. 
    require(msg.sender == owner, "Suck it punk, hands off my tendies!"); //makes sure the message sender is equal to the owner, or else gets the message
     _;
    }  //This code will later be used to restrict who can mint new tokens.

//The following code will create a constructor that will configure 
//the `ArcadeToken` contract and the `ERC20Detailed` contract:
    constructor(uint initial_supply) ERC20Detailed("funDrop", "DROP", 18) public {
    owner = msg.sender;
    _mint(owner, initial_supply);
    }
//a function called `mint` that accepts a recipient address and amount.
//Restrict this function to the contract owner by using  
    function mint(address recipient, uint amount) public onlyOwner {//the `onlyOwner` modifier that we created earlier.
    _mint(recipient, amount);
    }
}