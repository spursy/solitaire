pragma solidity ^0.4.21;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Solitaire.sol";

contract TestSolitaireContract {
    function testInfoContract() public{
        Info Solitaire_Cnntract = Solitaire(DeployedAddresses.Solitaire());
    }    
}