/* TOTALLY SWIPED FROM  https://dev.to/abdulmaajid/how-to-create-an-erc20-token-in-solidity-1a9h
I made no changes yet... we should check all this stuff make sure it's not a TRAP :-)

In order to create an ERC20 token, you need the following:
The Token’s Name
The Token’s Symbol
The Token’s Decimal Places
The Number of Tokens in Circulation */


pragma solidity ^0.8.0;

interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract SampleToken is IERC20 {
    using SafeMath for uint256;

    string public constant name = "SampleToken";
    string public constant symbol = "SMT";
    uint8 public constant decimals = 18;

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    uint256 totalSupply_;

    constructor(uint256 total) public {
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint256 numTokens) public override returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public override view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner].sub(numTokens);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}

library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
      assert(b <= a);
      return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
      uint256 c = a + b;
      assert(c >= a);
      return c;
    }
}

// End of copy and paste
/*  also says:
"We need to define two mapping objects. This is the Solidity notion for an associative or key/value array:"
more copy and paste: */
 mapping(address => uint256) balances;
 mapping(address => mapping (address => uint256)) allowed;

 /*The expression mapping(address => uint256) defines an associative array whose keys 
 are of type address. a number used to denote account addresses, and whose values are of 
 type uint256. Balances mapping, will hold the token balance of each owner account.

The second mapping object, allowed, will include all of the accounts approved to withdraw 
from a given account together with the withdrawal sum allowed for each.

After that we set the total amount of tokens at constructor (which is a special function 
automatically called by Ethereum right after the contract is deployed) and assign all of 
them to the “contract owner” i.e. the account that deployed the smart contract:
*/

// Jon - Here's the constructor part from the Token Contract part
uint256 totalSupply_;
constructor(uint256 total) public {
  totalSupply_ = total;
  balances[msg.sender] = totalSupply_;
}

/*  Get Total Token Supply
This function will return the number of all tokens allocated by this contract regardless of owner.*/
function totalSupply() public view returns (uint256) {
  return totalSupply_;
}

// Get Token Balance of Owner
//balanceOf will return the current token balance of an account, identified by its owner’s address.

function balanceOf(address tokenOwner) public view returns (uint256) {
   return balances[tokenOwner];
}

// Transfer Tokens to Another Account
// The transfer function is used to move numTokens amount of tokens from the owner’s balance to that of another 
// user, or receiver. The transferring owner is msg.sender i.e. the one executing the function.
function transfer(address receiver, uint256 numTokens) public returns (bool) {
    require(numTokens <= balances[msg.sender]);
    balances[msg.sender] = balances[msg.sender].sub(numTokens);
    balances[receiver] = balances[receiver].add(numTokens);
    emit Transfer(msg.sender, receiver, numTokens);
    return true;
}

// Approve user to Withdraw Tokens
// This function is most often used in a token marketplace scenario. 
// What approve does is to allow an owner i.e. msg.sender to approve a delegate 
// account to withdraw tokens from his account and to transfer them to other accounts.

function approve(address delegate, uint256 numTokens) public returns (bool) {
   allowed[msg.sender][delegate] = numTokens;
   emit Approval(msg.sender, delegate, numTokens);
   return true;
}

//Get Number of Tokens Approved for Withdrawal
//This function returns the current approved number of tokens by an owner to a 
//specific delegate, as set in the approve function.
function allowance(address owner, address delegate) public view returns (uint) {
   return allowed[owner][delegate];
}


//Transfer Tokens by Delegate
// The transferFrom function is the peer of the approve 
// function. It allows a delegate approved for withdrawal to transfer owner 
// funds to a third-party account.

function transferFrom(address owner, address buyer,
                     uint numTokens) public returns (bool) {
  require(numTokens <= balances[owner]);
  require(numTokens <= allowed[owner][msg.sender]);

  balances[owner] = balances[owner] — numTokens;
  allowed[owner][msg.sender] =
        allowed[from][msg.sender] — numTokens;
  balances[buyer] = balances[buyer] + numTokens;
  Transfer(owner, buyer, numTokens);
  return true;
}

