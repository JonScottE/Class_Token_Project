    function createSpendingRequest(string _description, address _recipient, uint _value) public onlyAdmin goalReached{
        
        
        // INSTANTIATING A Request STRUCT IN THE MEMORY
        Request memory newRequest = Request(
            {
                description:_description,
                value:_value,
                recipient:_recipient,
                numberOfVoters:0,
                completed:false
                }
            );
            
            
         // AN EXAMPLE OF A SPENDING REQUEST WOULD BE SOMETHING LIKE
         //   {
         //   description:"For Buying microchips for the product(A description would generally describe more than this :) )",
         //   value: 2000000000000000000 (2 ether converted to wei),
         //   recipient:0x12gfsk34j43.....,
         //   numberOfVoters:0,
         //   completed:false
         //   }
         
        
        
        
        
        // STORING THE SPENDING REQUEST STRUCT VARIABLE INTO THE requests DYNAMIC ARRAY
        requests.push(newRequest);
        }



        // don't repeat yourself probably needs to be inserted above this code
          
    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }
    modifier goalReached {
        require(raisedAmount >= goal);
        _;
    }