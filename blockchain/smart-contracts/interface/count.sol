// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Counter {

    uint8 public count;
    function increment() external {
        count = count +1;
    }



}
