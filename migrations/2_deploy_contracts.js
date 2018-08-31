const solitaire = artifacts.require('./solitaire.sol');

module.exports = function(developer) {
    developer.deploy(solitaire);
}