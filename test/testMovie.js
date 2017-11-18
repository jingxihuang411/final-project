const MovieFund = artifacts.require("./MovieFund.sol");
const MovieProvide = artifacts.require("./MovieProvide.sol");

contract('testMovie', function(accounts) {
    const args = {_owner: accounts[0], _buyer1: accounts[1], _buyer2: accounts[2]};
    let provider;

    beforeEach(async function() {
        provider = await MovieProvide.new("A", "https://movie.com",100);

    });

    describe('MovieTestGeneric', function() {
        it("should be able to deploy Movie contract", async function() {
            assert.ok(provider.address);
        });
    });
});