# Class_Token_Project
</br></br>
I -THINK- funDrop.sol (if that's what we're using for a name?!?!?!) is actually the right start?  I'm not sure if we need to inherit the "ERC20Mintable" open zepplin, if we're including our own mint function???  And the mint function probably needs to be improved...
</br></br>
YOOOOOOOO!!!! Check out "SelectWinner.sol" it's almost perfect already!!! But we need to adjust the end of the code so it's a percent of the whole, instead of a static number or single number.
</br></br>
From:</br> https://medium.com/quick-code/learning-solidity-with-a-simple-fundraising-smart-contract-2fad8b1d8b73 </br>
For StorageVariablesSpendRequest.sol , ConstructorFundraise.sol , ContributeFunction.sol </br></br>
Understanding the Smart Contract</br></br>
Before moving on to the code let’s understand exactly how our smart contract gonna work on a basic level.</br>
The Smart Contract operates in the following way:</br>
The admin will Start a Campaign or a Project for fundraising with a Specific Goal and Deadline.</br>
Contributors will contribute to that project by sending the required Tokens(in this case ether).</br>
The Admin will create a Spending Request every time he wants to use any amount from those funds</br>
The Contributors will vote for that Spending Request.</br>
If more than 50% of the total contributors vote for that request then the admin will get permission to use the amount mentioned in the Spending Request</br>
The contributors can withdraw their ether if the required amount(Goal) was not raised within the Deadline.</br>
Note: A spending request can only be created when the Goal is reached.</br>
