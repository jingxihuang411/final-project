var MovieFund = artifacts.require("./MovieFund.sol");
var MovieProvide = artifacts.require("./MovieProvide.sol");

module.exports = function(deployer) {
	deployer.deploy(MovieFund);
	deployer.deploy(MovieProvide);
};
