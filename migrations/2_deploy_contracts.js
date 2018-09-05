const Solitaire = artifacts.require('./SolitaireUpgrate.sol');

module.exports = function(developer) {
    developer.deploy(Solitaire);
}