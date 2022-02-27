// SPDX-License=Identifier:MIT
contract Counter{
    uint public counter;
    constructor(){
        counter =0;
    }
    function count() public{
        counter +=1;
    }
    function set(uint x) public{
        counter+=x;
    }
}