pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract MyERC20 is ERC20,ERC20Permit {

    constructor() ERC20("ADRCEITZ", "ADRCEITZ") ERC20Permit("ERC2612") {
        // _mint(msg.sender, 1000 * 10 ** 18);
    }
    function mint(address recipient,uint amount)public{
        _mint(recipient,amount);
    }
}