// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Counter{
    uint public counter;
    constructor(uint x){
        counter =x;
    }
    function count() public{
        counter +=1;
    }
    function set(uint x) public{
        counter+=x;
    }
}