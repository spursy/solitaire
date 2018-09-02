pragma solidity ^0.4.23;

import "contracts/Console.sol";

contract Solitaire is Console{
    uint randomNonce = 0;
    uint[] randomNumArray;
    mapping(address => uint) PayoffMatrix;

    event AddNewRandomNum(address user, uint RandomNum);
    event WinCoin(address user, uint256 CoinCount);
    event Deposit(address user, uint256 amout);
    function GetNonce() public returns (uint) {
        return randomNonce ++;
    }

    function GenerateRandom() public payable  returns (uint) {
        uint currentNonce = GetNonce();//GetNonce();

        uint random = uint(keccak256(abi.encodePacked(now, msg.sender, currentNonce)))%10;

        return random;
    }

    function SolitaireMain() public payable returns(uint) {
        uint randomNum = GenerateRandom();
        
        if (randomNumArray.length == 0) {
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
            require(address(this).balance > 100000000000000000 * deleteCount, "Contract address does not exist enough money.");
            ower.transfer(100000000000000000 * deleteCount);
            emit WinCoin(msg.sender, 100000000000000000 * deleteCount);
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
        emit Deposit(msg.sender, msg.value);
    }
   
    function deposit() public payable {
        SolitaireMain();
        emit Deposit(msg.sender, msg.value);
    }

    function GetBalance() public view returns(uint256) {
        return address(this).balance;
    }
}

contract CallTest {
    function deposit() public payable {
    }

    event logSendEvent(address to, uint value);
    function transferEther(address towho) public payable {
        require(address(this).balance > 100000000000000000, "Contract address does not exist enough money.");
        towho.transfer(100000000000000000);
        emit logSendEvent(towho, 100000000000000000);
    }

    function GetBalance() public view returns(uint256) {
        return address(this).balance;
    }
}