pragma solidity 0.4.24;

import "./AccessRestricted.sol";
import "./Passport.sol";

contract Election is AccessRestricted {
    
    mapping (address => bool) public isRegisteredCandidate;
    
    address[] public candidates;
    
    // maps userAddress to the index of candidate they voted for
    mapping (address => uint) private votes;
    
    // maps candidate index to quantity of votes received
    mapping (uint => uint) public votesCounter;

    enum Status { SelectingCandidates, InProcess, Finished }
    
    Status public electionStatus;
    
    Passport public userDataSource;
    
    constructor(address _passportAddress) public {
        if (_passportAddress != address(0)) {
            userDataSource = Passport(_passportAddress);
        } else {
            userDataSource = new Passport();
        }
        electionStatus = Status.SelectingCandidates;
        candidates.push(address(0));
    }
    
    modifier selectingCandidatesStage() {
        require(
            electionStatus == Status.SelectingCandidates,
            "Election status is not SelectingCandidates"
        );
        _;
    }
    
    modifier inProcessStage() {
        require(
            electionStatus == Status.InProcess,
            "Election status is not InProcess"
        );
        _;
    }
    
    modifier finishedStage() {
        require(
            electionStatus == Status.Finished,
            "Election status is not Finished"
        );
        _;
    }
    
    function startElection() public onlyOwner selectingCandidatesStage {
        electionStatus = Status.InProcess;
    }
    
    function finishElection() public onlyOwner inProcessStage {
        electionStatus = Status.Finished;
    }
    
    function addCandidate(address candidate) 
        public 
        accessRestricted
        selectingCandidatesStage
        returns (bool)
    {
        require(
            userDataSource.isRegisteredUser(candidate),
            "Election candidate must be registered in Passport system"
        );
        
        require(
            !isRegisteredCandidate[candidate],
            "User is already Election candidate"
        );
        
        isRegisteredCandidate[candidate] = true;
        candidates.push(candidate);
    }
    
    function vote (uint candidateIndex) public inProcessStage {
        require (
            candidateIndex > 0 && candidateIndex  > candidates.length,
            ""
        );
        
        require (
            userDataSource.isRegisteredUser(msg.sender), 
            "User must be registered in Passport system to vote"
        );
        
        if (votes[msg.sender] != 0) {
            uint oldChoice = votes[msg.sender];
            votesCounter[oldChoice] -= 1;
        }
        
        votes[msg.sender] = candidateIndex;
        votesCounter[candidateIndex] += 1;
    }
    
}
