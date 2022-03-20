# W4_1作业
* 部署自己的ERC20合约MyToken
* 编写合约MyTokenMarket实现：
   * AddLiquidity():函数内部调用UniswapV2Router添加MyToken与ETH的流动性
   * buyToken()：用户可调用该函数实现购买MyToken

作业要求：
1. 使用自己的 github 创建一个作业代码库
2. 每一次作业使用一个文件夹(w1) 
3. 提交代码、截图、交易 hash 等

## 目录
* [部署自己的ERC20合约MyToken](#部署自己的ERC20合约MyToken) 
* [编写合约MyTokenMarket实现：](#编写合约MyTokenMarket实现：) 
    * [AddLiquidity](#AddLiquidity) 
    * [buyToken](#buyToken) 

## 部署自己的ERC20合约MyToken
hash:[FA3258ED865F7811AC8A9559CB1F4BB7EBCEE2F272943C59CF72489D6FAC7E91](https://www.oklink.com/zh-cn/oec-test/tx/FA3258ED865F7811AC8A9559CB1F4BB7EBCEE2F272943C59CF72489D6FAC7E91)  
sol_code:[MyToken.sol](/W4-1/DATA/sol/MyToken.sol)  
![MyToken](/W4-1/DATA/picture/MyToken.png)  

## 编写合约MyTokenMarket实现：
hash:[46D85A9C3CCC3F2750B1C98AD53C42F019D2517B4DC119CAF4269199140D5A9B](https://www.oklink.com/zh-cn/oec-test/tx/46D85A9C3CCC3F2750B1C98AD53C42F019D2517B4DC119CAF4269199140D5A9B)  
sol_code:[MyTokenMarket.sol](/W4-1/DATA/sol/MyTokenMarket.sol)  
![MyTokenMarket](/W4-1/DATA/picture/MyTokenMarket.png)  
### AddLiquidity
```solidity
function AddLiquidity(uint tokenAmount) public payable {
    IERC20(myToken).safeTransferFrom(msg.sender, address(this),tokenAmount);
    IERC20(myToken).safeApprove(router, tokenAmount);
    IUniswapV2Router01(router).addLiquidityETH{value: msg.value}(myToken, tokenAmount, 0, 0, msg.sender, block.timestamp);
}
```
hash:[2D87410D3FB7EB88B800C4C4B4C74AAADF4BEE71151AD55F0FA3BC996E825BF0](https://www.oklink.com/zh-cn/oec-test/tx/2D87410D3FB7EB88B800C4C4B4C74AAADF4BEE71151AD55F0FA3BC996E825BF0)  
![AddLiquidity](/W4-1/DATA/picture/AddLiquidity.png)  
### buyToken
```solidity
function buyToken(uint minTokenAmount) public payable {
    address[] memory path = new address[](2);
    path[0] = weth;
    path[1] = myToken;
    IUniswapV2Router01(router).swapExactETHForTokens{value : msg.value}(minTokenAmount, path, msg.sender, block.timestamp);
}
```
hash:[6F193573B6FA30526BA0E01194BFD7C1CC7080DD57682DF98893416BCD8143D1](https://www.oklink.com/zh-cn/oec-test/tx/6F193573B6FA30526BA0E01194BFD7C1CC7080DD57682DF98893416BCD8143D1)  
![buyToken](/W4-1/DATA/picture/buyToken.png)  
