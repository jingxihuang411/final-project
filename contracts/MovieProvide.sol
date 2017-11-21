pragma solidity ^0.4.15;

import './MovieFund.sol';

contract MovieProvide {
    //other features that needs to be implemented: time range, refund, 
    using SafeMath for uint256;

    address public owner;

    //votes that each buyers vote for the movie
    mapping (address => uint256) public votes;

    //minimum price accepted for the movie
    uint256 price;
    uint256 numVotes;
    uint256 numBuyers;

    string name;
    string url;

    MovieFund movieFund;


    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function MovieProvide(string _name, string _url, uint256 _price) public {
        owner = msg.sender;
        price = _price;
        name = _name;
        url = _url;
        numVotes = 0;
        numBuyers = 0;
        movieFund = new MovieFund();

    }

    function buyMovie() payable public returns(string) {
        uint256 amount = msg.value;
        require(amount >= price);

        movieFund.addFunds(msg.sender, amount);
        numBuyers += 1;

        purchaseMovie(msg.sender, amount);
        return url;

    }

    function approveMovie() public returns(bool) {
        require(movieFund.balanceOf(msg.sender) >= price);
        require(votes[msg.sender] != 1);

        votes[msg.sender] = 1;
        numVotes += 1;

        voteApprove(msg.sender);
        return true;

    }


    function checkVotes() public returns(uint256) {
        return numVotes;
    }

    function checkBuyers() public returns(uint256) {
        return numBuyers;
    }

    function checkApprovePercent() public returns(uint256) {
        return numVotes.mul(100).div(numBuyers);
    }

    function checkFunds() public returns (uint256){
        return movieFund.getFundRaised();
    }

    function retrieveFunds() onlyOwner public {
//        transfer
    }


    event purchaseMovie(address sender, uint amount);
    event voteApprove(address _user);





}