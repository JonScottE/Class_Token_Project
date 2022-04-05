 constructor(uint _deadline,uint _goal,uint _minimumContribution) public{
        minimumContribution = _minimumContribution;
        deadline=block.number + _deadline;
        goal=_goal;
        admin = msg.sender;
    }