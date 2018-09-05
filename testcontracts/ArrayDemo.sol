pragma solidity ^0.4.23; /*数组类型Demo*/ 

contract DemoTypes303 { /*String数组例子*/ 
    string[] strArr; 
    function add(string str) public{ 
        strArr.push(str); 
    }

    function AddStr() public{
        add("add str");
    }

    function getStrAt(uint n) public view returns (string){ 
        string storage tmp = strArr[n-1]; 
        return tmp; 
    }

    function updateStrAt(uint n, string str) public{
        strArr[n] = str; 
    }

    function deleteStrAt(uint index) public{ 
        uint len = strArr.length; 
        if (index >= len) return; 
        for (uint i = index; i<len-1; i++) { 
            strArr[i] = strArr[i+1]; 
        }

        delete strArr[len-1]; 
        strArr.length--; 
    } 
    
    function getArrLength() public view returns (uint) {
        return strArr.length;
    }
    
    function getTheFirstItem() public view returns (string) {
        return strArr[1];
    }
}