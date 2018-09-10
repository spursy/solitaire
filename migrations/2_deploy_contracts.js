const Solitaire = artifacts.require('./MeiLian.sol');

module.exports = function(developer) {
    developer.deploy(Solitaire);
}