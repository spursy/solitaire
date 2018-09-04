pragma solidity ^0.4.23;

contract Solitaire {
    uint depositAmount = 100 finney;
    uint rollbackAmount = 90 finney;
    uint randomNonce = 0;
    uint[] randomNumArray;
    mapping(address => uint[]) PayoffMatrix;

    // 当有新的随机数字添加到池中时触发该事件
    event AddNewRandomNum(address user, uint RandomNum);
    event WinCoin(address user, uint256 CoinCount);
    // 充值事件
    event Deposit(address user, uint256 amout);

    constructor() public payable{
    }

    function GetNonce() public returns (uint) {
        return randomNonce ++;
    }

    // 散列生成随机数字
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

    // 计算随机数是否在存在池中
    function calculateWiners(uint randomNum) public  returns(uint[]) {
        bool isMatching = false;
        uint length = randomNumArray.length;
        uint matchingindex;
        for (uint index = 0; index < length; index ++) {
            if (randomNum == randomNumArray[index]) {
                isMatching = true;
                matchingindex = index;
            }
        }
        if (!isMatching) {
            // PayoffMatrix[msg.sender].push(randomNum);
            randomNumArray.push(randomNum);
            emit AddNewRandomNum(msg.sender, randomNum);
        } else {
            for (uint i = length - 1; i >= matchingindex; i --) {
                delete randomNumArray[i];
            }
            address ower = msg.sender;
            uint interval = length - matchingindex + 1;
            require(address(this).balance >= rollbackAmount * interval, "Contract address does not exist enough money.");
            ower.transfer(rollbackAmount * interval);
            emit WinCoin(msg.sender, rollbackAmount * interval);
        }
        return randomNumArray;
    }

    function getRandomArrayLength() public view returns(uint) {
        return randomNumArray.length;
    }

    function getRandomNumArray() public view returns(uint[]) {
        return randomNumArray;
    }

    function GetRandomNumByAddress(address addr) public view returns(uint[]) {
        return PayoffMatrix[addr];
    }

    // 通过合约地址充值触发该事件
    function () public payable{
        require(msg.value == depositAmount, "Deposit money must be 100 finnery");
        SolitaireMain();
        emit Deposit(msg.sender, msg.value);
    }
   
    // 合约的充值函数
    function deposit() public payable {
        SolitaireMain();
        emit Deposit(msg.sender, msg.value);
    }

    // 获取合约余额的函数
    function GetBalance() public view returns(uint256) {
        return address(this).balance;
    }
}


// 向Solitaire合约转账的测试合约
contract CallTest {
    uint depositAmount = 100 finney;
    event logSendEvent(address to, uint value);
    event depositvalue(address sender, uint value);
    
    function transferEther(address towho) public payable {
        require(address(this).balance >= depositAmount, "Contract address does not exist enough money.");
        // towho.transfer(depositAmount);
        towho.call.value(depositAmount)();
        emit logSendEvent(towho, depositAmount);
    }

    function deposit() public payable {
        emit depositvalue(msg.sender, msg.value);
    }

    function GetBalance() public view returns(uint256) {
        return address(this).balance;
    }
}