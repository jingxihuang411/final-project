pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Purchase.sol";

contract TestPurchase {
    Purchase purchase = Purchase(DeployedAddresses.Purchase());

    // Testing the buy() function
    function testPurchaseRecorded() public {
        // Expected owner is this contract
        purchase.buy(0);
        Assert.equal(purchase.hasPurchased(0, this), true, "Owner of video ID 0 should be recorded.");
    }
}