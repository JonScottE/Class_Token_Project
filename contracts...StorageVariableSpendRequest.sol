
    // Defining a Struct for a Spending Request
    struct  Request  {
        string description;
        uint value;
        address recipient;
        bool completed;
        uint numberOfVoters;
        mapping(address=>bool) voters;
    }
   
   // STORAGE VARIABLES
   mapping(address=>uint) public contributions;
    uint public totalContributors;    // TOTAL COUNT OF CONTRIBUTORS
    uint public minimumContribution;
    uint public deadline;             // DEADLINE IN BLOCK NUMBER
    uint public goal;                 // AMOUNT NEEDS TO BE RAISED
    uint public raisedAmount = 0 ;    // AMOUNT RAISED
    address public admin;             // PROJECT OWNER
  
    Request[] public requests;