var Purchase = artifacts.require("Purchase");
var Vote = artifacts.require("Vote");
var Video = artifacts.require("Video");

module.exports = function(deployer) {
  deployer.deploy(Video);
  deployer.deploy(Vote);
  deployer.deploy(Purchase);
};