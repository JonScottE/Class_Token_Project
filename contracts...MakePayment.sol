
  function makePayment(uint index) public onlyAdmin goalReached{
  
        // Directly referencing the  specific spending request inside the requests dynamic array
        
        Request storage thisRequest = requests[index];
        
        // Checking the necessary conditions
        
        require(thisRequest.completed == false);
        require(thisRequest.numberOfVoters > totalContributors / 2);//more than 50% voted
        
        // Performing the operations
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed = true;
    }