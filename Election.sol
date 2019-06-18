pragma solidity 0.4.25;

import "./Roles.sol";

contract Passport {
	function userExist(address userAddress) public view returns(bool);
}

contract Election is Roles {
    
    Passport private passportContract;
    uint private _totalHolders;
    mapping(uint => address) private holders;
    mapping(address => uint) private votes;
    bool private voteEnded;
    
    constructor(address PassportAddr) public {
        _totalHolders = 0;
        voteEnded = false;
        passportContract = Passport(PassportAddr);
    }
    
    modifier isRegistered(address candidateAddr) {
        require(passportContract.userExist(candidateAddr) == true, "User doesn't exist.");
        _;
    }
    
    modifier notActive() {
       require(voteEnded == true, "Voting didn't end.");
        _; 
    }
    
    modifier isActive() {
        require(voteEnded == false, "Voting ended.");
        _;
    }

    function vote(address candidateAddr) onlyUser isRegistered(candidateAddr) isActive external {
        holders[_totalHolders] = candidateAddr;
        votes[candidateAddr] = votes[candidateAddr] + 1;
        _totalHolders += 1;
    }
    
    function endVoting() onlyOwner isActive external {
        voteEnded = true;
    }
    
    function calculateWinner() onlyOwner notActive view external returns (address, uint) {
        uint winnerVotes = 0;
        address winner;
        
        for (uint8 i=0; i <= _totalHolders; i++) {
            uint num = votes[holders[i]];
            if (num > winnerVotes) {
                winnerVotes = num;
                winner = holders[i];
            }
        }
        return (winner, winnerVotes);
    }

}