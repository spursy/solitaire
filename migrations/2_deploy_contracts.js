const Solitaire = artifacts.require('./Solitaire.sol');

module.exports = function(developer) {
    developer.deploy(Solitaire);
}