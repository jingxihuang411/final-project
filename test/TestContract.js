const Purchase = artifacts.require("./Purchase.sol");
const Vote = artifacts.require("./Vote.sol");
const Video = artifacts.require("./Video.sol");

contract('TestContract', function(accounts) {
    const args = {_owner: accounts[0], _buyer1: accounts[1], _buyer2: accounts[2]};
    let purchase, vote, video;

    beforeEach(async function() {
        purchase = await Purchase.new({from: args._owner});
        vote = Vote.at(await purchase.allVotes());
        video = Video.at(await purchase.allVideos());

    });

    describe('TestGenerics', function() {
        it("should be able to deploy contract", async function() {
            assert.ok(purchase.address);
            assert.ok(vote.address);
        });
        it("should have initialize correctly", async function() {
            assert.equal(await vote.checkVotes(0),0);
            assert.equal(await purchase.hasPurchased(0, args._buyer1), false);
        });
    });

    describe('TestVote', function() {
        it("should be able to vote video", async function() {
            purchase.buy(0,{from: args._buyer1});
            assert.equal(await purchase.hasPurchased(0, args._buyer1), true);

            purchase.approveVideo(0,{from: args._buyer1});
            assert.equal(await vote.checkVotes(0), 1);
        });
        it('should not be able to vote without buying', async function() {
            purchase.approveVideo(1,{from: args._buyer2});
            assert.equal(await vote.checkVotes(1), 0);
        });
        it('should avoid duplicate votes', async function() {
            purchase.buy(0,{from: args._buyer2});
            purchase.approveVideo(0,{from: args._buyer2});
            purchase.approveVideo(0,{from: args._buyer2});
            assert.equal(await vote.checkVotes(0), 1);
        });

    });

    describe('TestVideo', function() {
        it('should be able to initialize with 2 videos', async function() {
            assert.equal(await video.getNumVideo(), 2);
        });

    });

    describe('TestPurchase', function() {
        it('should be able to check score of video', async function() {
            assert.equal(await purchase.checkScore(0), 0);
        });
        it("should be able to purchase free video", async function() {
            purchase.buy(0,{from: args._buyer1});
            assert.equal(await purchase.hasPurchased(0, args._buyer1), true);
        });
        it("should be able to purchase video when pay more than price", async function() {
            purchase.buy(1,{from: args._buyer1, value: 1});
            assert.equal(await purchase.hasPurchased(1, args._buyer1), true);
        });
        it("should be able to check score of video", async function() {
            purchase.buy(0,{from: args._buyer1});
            purchase.buy(0,{from: args._buyer2});
            purchase.approveVideo(0,{from: args._buyer2});
            assert.equal(await purchase.checkScore(0), 50);
        });
        it("should be able to add video", async function() {
            purchase.addVideo(0,"Batman", "https://batman.com");
            assert.equal(await video.getPrice(2), 0);
            assert.equal(await video.getName(2), "Batman");
            assert.equal(await video.getNumVideo(), 3);
        });
    });


});