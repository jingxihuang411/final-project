pragma solidity ^0.4.15;

import './utils/SafeMath.sol';

contract MovieFund {
    using SafeMath for uint256;

    address public owner;
    mapping (address => uint256) public buyersBalance;

    uint256 totalFunds;


    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function MovieFund() public {
        owner = msg.sender;
        totalFunds = 0;
    }

    function balanceOf(address _user) constant returns (uint256 balance){
        return buyersBalance[_user];
    }


    function addFunds(address _buyer, uint256 amount) {
        buyersBalance[_buyer].add(amount);
        totalFunds.add(amount);
        addFunds(_buyer, amount);
    }

    function getFundRaised() returns (uint256){
        return totalFunds;
    }

    event addMovieFunds(address sender, uint amount);





}