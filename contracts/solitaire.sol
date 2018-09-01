pragma solidity ^0.4.23;

contract Solitaire {
    uint randomNonce = 0;
    uint[] randomNumArray;
    mapping(address => uint) PayoffMatrix;

    event AddNewRandomNum(address user, uint RandomNum);
    event WinCoin(address user, uint256 CoinCount);
    function GetNonce() public returns (uint) {
        return randomNonce ++;
    }

    function GenerateRandom() public payable  returns (uint) {
        uint currentNonce = GetNonce();//GetNonce();

        uint random = uint(keccak256(abi.encodePacked(now, msg.sender, currentNonce)))%20;

        return random;
    }

    function SolitaireMain() public payable returns(uint) {
        uint randomNum = GenerateRandom();
        
        if (randomNumArray.length == 0) {
            PayoffMatrix[msg.sender] = randomNum;
            randomNumArray.push(randomNum);
        } else {
            calculateWiners(randomNum);
        }   
    }

    function calculateWiners(uint randomNum) public  returns(uint[]) {
        bool isMapping = false;
        uint deleteCount = 0;
        uint length = randomNumArray.length;
        for (uint index = 0; index < length; index ++) {
            if (isMapping) {
                delete randomNumArray[length-1-deleteCount]; 
                randomNumArray.length--; 
                deleteCount ++;
            } else if (randomNumArray[index] == randomNum) {
                isMapping = true;
                delete randomNumArray[length-1]; 
                randomNumArray.length--; 
                deleteCount ++;
            } 
        }
        if (!isMapping) {
            PayoffMatrix[this] = randomNum;
            randomNumArray.push(randomNum);
            emit AddNewRandomNum(msg.sender, randomNum);
        } else {
            address ower = msg.sender;
            require(address(this).balance > 0.1 * 10^18 * deleteCount, "Contract address does not exist enough money.");
            ower.transfer(0.1 * 10^18 * deleteCount);
            emit WinCoin(msg.sender, 0.1 * 10 ^ 18);
        }
        return randomNumArray;
    }

    function getRandomNumArray() public view returns(uint[]) {
        return randomNumArray;
    }

    function GetRandomNumByAddress() public view returns(uint) {
        return PayoffMatrix[msg.sender];
    }

    function () public payable{
        SolitaireMain();
    }
   
    function deposit() public payable {
    }
}