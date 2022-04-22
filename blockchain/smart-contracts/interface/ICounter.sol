// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface ICounter{
    function count() external view returns (uint);
    function increment() external;
}

contract MyContract {

    function incrementCounterEx(address _counteradd) external{
        ICounter(_counteradd).increment();
    }

    function getCount(address _counteradd) external view returns (uint){
        return ICounter(_counteradd).count();
    }

}
