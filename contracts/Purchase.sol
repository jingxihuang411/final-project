pragma solidity ^0.4.4;

import './Vote.sol';
import './Video.sol';

contract Purchase {
    uint256[16] public numBuyers;
    mapping (uint256 => mapping(address => bool)) public allBuyers;

    Vote public allVotes;
    Video public allVideos;

    function Purchase() public {
        allVotes = new Vote();
        allVideos = new Video();
    }

    // Buy a video
    function buy(uint videoId) payable public returns (bool) {
        if (videoId < 0 || videoId > 15 || allVideos.getPrice(videoId) > msg.value) {
            msg.sender.transfer(msg.value);
            return false;
        }
        numBuyers[videoId] += 1;
        allBuyers[videoId][msg.sender] = true;
        return true;

    }

    function hasPurchased(uint videoId, address buyer) constant public returns(bool) {
        return allBuyers[videoId][buyer];
    }

    function approveVideo(uint videoId) public returns(bool){
        //voter must bought the video before
        if (!hasPurchased(videoId, msg.sender)) {
            return false;
        }
        allVotes.vote(videoId, msg.sender);
        return true;
    }

    function checkScore(uint videoId) constant public returns(uint256) {
        return 100 * allVotes.checkVotes(videoId) / numBuyers[videoId];
    }

    function addVideo(uint _price, string _name) public returns(uint256) {
        return allVideos.addVideo(_price, _name);
    }

//    function retrieveMoney(address owner, uint videoId) public returns(bool) {
//        uint256 numBuyer = numBuyers[videoId];
//        if (checkScore(videoId) >= 80 && numBuyer >= allVideos.getPrice(videoId) * 10) {
//            if (allVideos.isOwner(owner, videoId)) {
//                owner.transfer(numBuyer * allVideos.getPrice(videoId));
//                return true;
//            }
//        }
//        return false;
//    }

}