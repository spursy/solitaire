pragma solidity ^0.4.23;

contract ArrayFix {
    uint[] arr = new uint[](20);

    function addItem(uint item) public  {
        arr.push(item);
    }

    function getArr() public view returns(uint[]) {
        return arr;
    }
}