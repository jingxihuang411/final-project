pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Purchase.sol";

contract TestPurchase {
    Purchase purchase = Purchase(DeployedAddresses.Purchase());

    // Testing the buy() function
    function testUserCanPurchase() public {
        bool result = purchase.buy(0);

        bool expected = true;

        Assert.equal(result, expected, "Purchase of video ID 0 should be recorded.");
    }

    // Testing retrieval of a single pet's owner
    function testPurchaseRecorded() public {
        // Expected owner is this contract
        Assert.equal(purchase.hasPurchased(0, this), true, "Owner of video ID 0 should be recorded.");
    }
}