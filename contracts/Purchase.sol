pragma solidity ^0.4.4;

import './Vote.sol';
import './Video.sol';

contract Purchase {
    uint256[] public numBuyers;
    string[] public urls;
    mapping (uint256 => mapping(address => bool)) public allBuyers;

    Vote public allVotes;
    Video public allVideos;

    function Purchase() public {
        allVotes = new Vote();
        allVideos = new Video();

        //initialize the contract with 2 default videos
        addVideo(0, "Despicable_Me", "https://despicableMe.com");
        addVideo(0, "Wonder_Woman", "https://wonderWoman.com");
    }

    // Buy a video
    function buy(uint videoId) payable public returns (string) {
        if (videoId < 0 || videoId > numBuyers.length || allVideos.getPrice(videoId) > msg.value) {
            msg.sender.transfer(msg.value);
            return "Purchase failed.";
        }
        numBuyers[videoId] += 1;
        allBuyers[videoId][msg.sender] = true;
        return urls[videoId];
    }

    function hasPurchased(uint videoId, address buyer) constant public returns(bool) {
        return allBuyers[videoId][buyer];
    }

    function approveVideo(uint videoId) public returns(bool){
        //voter must bought the video before
        if (!hasPurchased(videoId, msg.sender) || !allVotes.vote(videoId, msg.sender)) {
            return false;
        }
        return true;
    }

    function checkScore(uint videoId) constant public returns(uint256) {
        if (numBuyers[videoId] == 0) {
            return 0;
        }
        return 100 * allVotes.checkVotes(videoId) / numBuyers[videoId];
//        return allVotes.checkVotes(videoId);
    }

    function getPrice(uint videoId) constant public returns(uint256) {
        uint256 price = allVideos.getPrice(videoId);
        return price;
    }

    function addVideo(uint _price, string _name, string _url) public returns(uint256) {
        urls.push(_url);
        numBuyers.push(0);
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