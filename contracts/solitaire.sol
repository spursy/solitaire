pragma solidity ^0.4.23;

contract solitaire {
    uint randomNonce = 0;
    uint[] randomNumArray;
    mapping(address => uint) PayoffMatrix;

    function GetNonce() public returns (uint) {
        return randomNonce ++;
    }

    // internal

    function GenerateRandom() public payable  returns (uint) {
        uint currentNonce = GetNonce();//GetNonce();

        uint random = uint(keccak256(abi.encodePacked(now, msg.sender, currentNonce)))%20;

        return random;
    }

    function SolitaireMain() public payable returns(uint) {
        uint randomNum = GenerateRandom();
        uint length = randomNumArray.length;
        bool isMapping = false;
        uint deleteCount = 0;
        
        if (length == 0) {
            PayoffMatrix[this] = randomNum;
            randomNumArray.push(randomNum);
        }
        
        for (uint index = 0; index < length; index ++) {
            if (isMapping) {
                delete randomNumArray[length-1-deleteCount]; 
                randomNumArray.length--; 
                deleteCount ++;
            }
            else if (randomNumArray[index] == randomNum) {
                isMapping = true;
                delete randomNumArray[length-1]; 
                randomNumArray.length--; 
                deleteCount ++;
            } else {
                PayoffMatrix[this] = randomNum;
                randomNumArray.push(randomNum);
            }
        }
        return randomNum;
    }

    function getRandomNumArray() public view returns(uint[]) {
        return randomNumArray;
    }
}