pragma solidity ^0.4.21;

contract Console {
    event LogUint(string s, string x);
    function log(string s, string x) internal {
        emit LogUint(s, x);
    }
}