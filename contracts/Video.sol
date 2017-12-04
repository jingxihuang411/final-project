pragma solidity ^0.4.4;

contract Video {
    address[] public owner;
    uint256 public numVideo;
    uint256[] public minPrice;
    string[] public name;


    function Video() public {
        numVideo = 0;
    }

    function addVideo(uint _price, string _name) public returns(uint256) {
        owner.push(msg.sender);
        minPrice.push(_price);
        name.push(_name);
        numVideo += 1;

        addVideoEvent(numVideo-1, _price, _name);
        return numVideo-1;
    }

    function getPrice(uint256 videoId) constant public returns(uint256){
        return minPrice[videoId];
    }

    function getName(uint256 videoId) constant public returns(string) {
        return name[videoId];
    }

    function getNumVideo() constant public returns(uint256) {
        return numVideo;
    }

    function isOwner(address _owner, uint videoId) public returns(bool) {
        return owner[videoId] == _owner;
    }


    event addVideoEvent(uint _videoId, uint _price, string _name);




}