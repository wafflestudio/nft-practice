const WaffleToken = artifacts.require("WaffleToken")

module.exports = function (deployer) {
    deployer.deploy(WaffleToken);
};
