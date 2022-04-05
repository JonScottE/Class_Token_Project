  function getRefund() public {
        // REQUIRED CONDITIONS FOR GETTING A REFUND
        
        require(block.number > deadline);
        require(raisedAmount < goal);
        require(contributions[msg.sender] > 0);
        
        
        msg.sender.transfer(contributions[msg.sender]);
        contributions[msg.sender] = 0;
       
    }