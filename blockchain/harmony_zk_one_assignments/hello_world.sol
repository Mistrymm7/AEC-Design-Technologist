// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract HelloWorld {
    uint public number;

    // Function to get the current number
    function retrieveNumber() public view returns (uint) {
        return number;
    }

    // Function to change number
    function storeNumber(uint _newnum) public {
        number = _newnum;
    }

    
}
