// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
}
interface IERC20Permit {
    function permit(address owner,address spender,uint256 value,uint256 deadline,uint8 v,bytes32 r,bytes32 s) external;
}


contract Vault {
    mapping(address=>uint256)public deposited;
    address token;
    constructor(address _token) {
        token = _token;
    }
    function deposit(address user,uint256 amount)public returns(bool){
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "Transfer from error");
        deposited[user]+=amount;
        return true;
    }
    function permitDeposit(address user, uint amount, uint deadline, uint8 v, bytes32 r, bytes32 s) external returns(bool) {
        IERC20Permit(token).permit(msg.sender, address(this), amount, deadline, v, r, s);
        deposit(user, amount);
        return true;
    }

    function withdraw(address user,uint256 amount)external returns(bool){
        deposited[msg.sender]-=amount;
        IERC20(token).transfer(user,amount);
        return true;
    }
}