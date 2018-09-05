pragma solidity ^0.4.0;

contract AddrTest{
    event logdata(bytes data);
    function() public payable {
        emit logdata(msg.data);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    uint score = 0;
    function setScore(uint s) public {
        score = s;
    }

    function getScore() public view returns ( uint){
        return score;
    }
}

contract CallTest{
    function deposit() public payable {
    }

    event logSendEvent(address to, uint value);
    function transferEther(address towho) public  payable {
        towho.transfer(10);
        emit logSendEvent(towho, 10);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;//0
    }  
}