pragma solidity 0.8.4;
import 'openzeppelin-contracts/contracts/security/ReentrancyGuard.sol';
import "openzeppelin-contracts/contracts/security/Pausable.sol";

contract InSecureumDAO is Pausable, ReentrancyGuard {
    
    // Assume that all functionality represented by ... below is implemented as expected
     
    address public admin;
    mapping (address => bool) public members;
    // @audit-info - This is a mapping of voteId to possible outcomes
    mapping (uint256 => uint8[]) public votes;
    mapping (uint256 => uint8) public winningOutcome;
    // @audit - unnecessary assignment to 0
    // @audit-issue - This is not used
    uint256 memberCount = 0;
    uint256 membershipFee = 1000;
     
    modifier onlyWhenOpen() {
        // @audit - Ether can be forcefully sent to this contract
        require(address(this).balance > 0, 'InSecureumDAO: This DAO is closed');
        _;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }

    modifier voteExists(uint256 _voteId) {
       // Assume this correctly checks if _voteId is present in votes
        //...
        _;
    }
    
    constructor (address _admin) {
        require(_admin == address(0));
        admin = _admin;
    }
  
    function openDAO() external payable onlyAdmin {
        // Admin is expected to open DAO by making a notional deposit
        //...
    }

    function join() external payable onlyWhenOpen nonReentrant {
        // @audit-issue - Dangerous strict equality operator
        // it is hard to make msg.value exact equal to membershipFee due to gas fees etc.
        require(msg.value == membershipFee, 'InSecureumDAO: Incorrect ETH amount');
        members[msg.sender] = true;
        //...
    }

    // @audit - Pause is not called anywhere, contract cannot be paused?
    // @audit-issue only members should be able to create votes
    function createVote(uint256 _voteId, uint8[] memory _possibleOutcomes) external onlyWhenOpen whenNotPaused {
        // @audit-issue - No input validation
        votes[_voteId] = _possibleOutcomes;
        //...
    }

    // @audit - Same as above, contract cannot be paused.
    // @audit-issue - only members should be able to cast votes
    function castVote(uint256 _voteId, uint8 _vote) external voteExists(_voteId) onlyWhenOpen whenNotPaused {
        // @audit-issue - No input validation
        //...
    }

    function getWinningOutcome(uint256 _voteId) public view returns (uint8) {
        // Anyone is allowed to view winning outcome
        //...
        // @audit - It might be usefull to check if the voteId exists
        // for example by checking if there were votes casted for this voteId
        return(winningOutcome[_voteId]);
    }
  
    function setMembershipFee(uint256 _fee) external onlyAdmin {
        // @audit-issue - No input validation, admin can make a typo and set the wrong fee
        membershipFee = _fee;
    }
  
    // @audit - lol
    function removeAllMembers() external onlyAdmin {
        // @audit - Does it remove the admin from members?
        delete members[msg.sender];
    }  
}
