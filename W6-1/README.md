# W6_1作业
* 设计一个看涨期权Token:
   * 创建期权Token 时，确认标的的价格与行权日期；
   * 发行方法（项目方角色）：根据转入的标的（ETH）发行期权Token；
   * 行权方法（用户角色）：在到期日当天，可通过指定的价格兑换出标的资产，并销毁期权Token
   * 过期销毁（项目方角色）：销毁所有期权Token 赎回标的。

作业要求：
1. 使用自己的 github 创建一个作业代码库
2. 每一次作业使用一个文件夹(w1) 
3. 提交代码、截图、交易 hash 等

## 目录
* [设计一个看涨期权Token](#设计一个看涨期权Token) 
    * [创建期权Token](#创建期权Token) 
    * [发行方法](#发行方法) 
    * [行权方法](#行权方法) 
    * [过期销毁](#过期销毁) 

## 设计一个看涨期权Token
hash:[0B4B04B89A9CDBA3979C9ADFC81B789959D0471931C920624E9F7040F14F98BB](https://www.oklink.com/zh-cn/oec-test/tx/0B4B04B89A9CDBA3979C9ADFC81B789959D0471931C920624E9F7040F14F98BB)  
sol_code:[OptToken_To_ETH.sol](/W6-1/DATA/Bank/OptToken_To_ETH.sol)  
### 创建期权Token
确认标的的价格与行权日期
```solidity
function set_sell()private onlyOwner{
    buy_token=0xb5D72BB101A384FFE2696c3A0f85c5Af1c9C8889;//付费token
    sell_token=0x982A1148791599EDdc55d956548349bC5e634676;//期权token
    fee=1;//期权费用千分之一
    price=3000;//期权token价格
    settlementTime=block.timestamp+0;
    during=settlementTime+1000;
}
```  
### 发行方法
hash:[EC2F808457D3B1E50C299B175E4BD16E19AC64C7BB143E4ADD4C0196E3C51344](https://www.oklink.com/zh-cn/oec-test/tx/EC2F808457D3B1E50C299B175E4BD16E19AC64C7BB143E4ADD4C0196E3C51344)  
```solidity
    function add_sell_token(uint amount)public{
        IERC20(sell_token).safeTransferFrom(msg.sender, address(this), amount);
        _mint(address(this), amount);
    }
```  
### 购买期权
hash:[99126E82BDE1F7E6A462B25C2AB8C9F9EA6D88AA610F0DF9122187BCDF9C0287](https://www.oklink.com/zh-cn/oec-test/tx/99126E82BDE1F7E6A462B25C2AB8C9F9EA6D88AA610F0DF9122187BCDF9C0287)  
```solidity
    function sell_OptToken(uint amount)public{
        uint famount = amount*price*fee/10000;
        IERC20(buy_token).safeTransferFrom(msg.sender, address(this), famount);
        IERC20(address(this)).transfer(msg.sender,amount);
    }
```  

### 行权方法
hash:[7F446A1ED70088058820C549638C7C9338EEC44736A5DC6C3390D02B42324817](https://www.oklink.com/zh-cn/oec-test/tx/7F446A1ED70088058820C549638C7C9338EEC44736A5DC6C3390D02B42324817)  
```solidity
    function exercise(uint amount)public{
        require(block.timestamp >= settlementTime && block.timestamp < during, "invalid time");
        _burn(msg.sender, amount);
        IERC20(buy_token).safeTransferFrom(msg.sender, address(this), amount*price);
        IERC20(sell_token).safeTransfer(msg.sender, amount);
    }
```  
### 过期销毁
hash:[ED71442356EE352730259F0FC937F5C218C6563CF8574903CA9B792CE6AA8291](https://www.oklink.com/zh-cn/oec-test/tx/ED71442356EE352730259F0FC937F5C218C6563CF8574903CA9B792CE6AA8291)  
```solidity
    function burnAll()external onlyOwner{
        require(block.timestamp > during, "invalid time");
        _burn(address(this), balanceOf(address(this)));
        IERC20(sell_token).safeTransfer(msg.sender, IERC20(sell_token).balanceOf(address(this)));
        IERC20(buy_token).safeTransfer(msg.sender, IERC20(buy_token).balanceOf(address(this)));
    }
```  