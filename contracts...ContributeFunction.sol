function contribute() public payable {
        
        //CONDITIONS FOR EXECUTING THE REST OF THE FUNCTION
        
        require(msg.value > minimumContribution);
        require(block.number < deadline);
        
        // CHECKING WHETHER THIS IS THE FIRST TIME THAT APERSON IS CONTRIBUTING TO THIS CAMPAIGN
        
        if(contributions[msg.sender] == 0)
        {
        
        // IF ITS HIS FIRST CONTRIBUTION WE NEED TO INCREMENT THE totalContributors STORAGE VARIABLE BY 1
        
            totalContributors++;
        }
        
        // IF ITS NOT HIS/HER FIRST TIME CONTRIBUTING  THEN WE SIMPLY ADD THE AMOUNT SENT TO HIS/HER PREVIOUS CONTRIBUTION
        // AND THEN ALSO ADD THE AMOUNT SENT TO THE raisedAmount STORAGE VARIABLE
        
        contributions[msg.sender] += msg.value;
        raisedAmount+=msg.value;
    }