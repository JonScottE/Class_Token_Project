function voteForRequest(uint index) public goalReached {

        // Directly referencing the  specific spending request inside the requests dynamic array
        
        Request storage thisRequest = requests[index];
        
        // Checking for the conditions
        
        require(contributions[msg.sender] > 0);
        require(thisRequest.voters[msg.sender] == false);
        
        //Counting the vote and then incrementing the number of voters by 1
        thisRequest.voters[msg.sender] = true;
        thisRequest.numberOfVoters++;
    }