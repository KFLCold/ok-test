//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract OptToken_To_ETH is ERC20, Ownable {
    using SafeERC20 for IERC20;
    constructor() ERC20("OptToken_To_TETH", "OptToken_To_TETH") {
         set_sell();
    }
    address buy_token;//购买代币
    address sell_token;//售出代币
    uint fee;//期权费率
    uint price;//期权价格
    uint public settlementTime;//可行权日期
    uint public during;//行权到期时间

    function set_sell()private onlyOwner{
        buy_token=0xb5D72BB101A384FFE2696c3A0f85c5Af1c9C8889;
        sell_token=0x982A1148791599EDdc55d956548349bC5e634676;
        fee=1;
        price=3000;
        settlementTime=block.timestamp+0;
        during=settlementTime+1000;
    }
    function set_time(uint time1,uint time2)public{
        settlementTime=block.timestamp+time1;
        during=settlementTime+time2;
    }
    function add_sell_token(uint amount)public{
        IERC20(sell_token).safeTransferFrom(msg.sender, address(this), amount);
        _mint(address(this), amount);
    }

    function sell_OptToken(uint amount)public{
        uint famount = amount*price*fee/10000;
        IERC20(buy_token).safeTransferFrom(msg.sender, address(this), famount);
        IERC20(address(this)).transfer(msg.sender,amount);
    }

    function exercise(uint amount)public{
        require(block.timestamp >= settlementTime && block.timestamp < during, "invalid time");
        _burn(msg.sender, amount);
        IERC20(buy_token).safeTransferFrom(msg.sender, address(this), amount*price);
        IERC20(sell_token).safeTransfer(msg.sender, amount);
    }

    function burnAll()external onlyOwner{
        require(block.timestamp > during, "invalid time");
        _burn(address(this), balanceOf(address(this)));
        IERC20(sell_token).safeTransfer(msg.sender, IERC20(sell_token).balanceOf(address(this)));
        IERC20(buy_token).safeTransfer(msg.sender, IERC20(buy_token).balanceOf(address(this)));
    }
}