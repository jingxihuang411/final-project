pragma solidity ^0.4.4;

contract Vote {

    uint256[1000] public numVotes;
    mapping (uint256 => mapping(address => uint256)) public voters;
    address public owner;

    function Vote() public {
        owner = msg.sender;
    }

    // Votes agree for a video
    function vote(uint videoId, address voter) public returns(bool){

        //avoid duplicate votes
        if (videoId < 0 || videoId > numVotes.length || voters[videoId][voter] == 1) {
            return false;
        }
        numVotes[videoId] += 1;
        voters[videoId][voter] = 1;

        voteApprove(voter);
        return true;
    }

    function checkVotes(uint videoId) constant public returns(uint256) {
        return numVotes[videoId];
    }

    event voteApprove(address _user);

}