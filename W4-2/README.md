# W4_2作业
* 在上一次作业的基础上：
   * 完成代币兑换后，直接质押MasterChef
   * withdraw():从MasterChef提取Token方法

作业要求：
1. 使用自己的 github 创建一个作业代码库
2. 每一次作业使用一个文件夹(w1) 
3. 提交代码、截图、交易 hash 等

## 目录
* [在上一次作业的基础上：](#在上一次作业的基础上：) 
    * [完成代币兑换后，直接质押MasterChef](#完成代币兑换后，直接质押MasterChef) 
    * [withdraw()](#withdraw()) 

## 在上一次作业的基础上：
### 完成代币兑换后，直接质押MasterChef
hash:[6EE88DEFBCEA4E2F53E3988F94E933BF1855D93B3D6BBD9B848D7D062CDD8804](https://www.oklink.com/zh-cn/oec-test/tx/6EE88DEFBCEA4E2F53E3988F94E933BF1855D93B3D6BBD9B848D7D062CDD8804)
```solidity
function AddLiquidity(uint tokenAmount) public payable {
    IERC20(myToken).safeTransferFrom(msg.sender, address(this),tokenAmount);
    IERC20(myToken).safeApprove(router, tokenAmount);
    IUniswapV2Router01(router).addLiquidityETH{value: msg.value}(myToken, tokenAmount, 0, 0, msg.sender, block.timestamp);
}
```  
![MasterChef](/W4-2/DATA/picture/MasterChef.png)  

### withdraw
hash:[0C2A873B6952DF74868A1EEA3B7536BE40A49A25CA810B911FCAC5456CD1353D](https://www.oklink.com/zh-cn/oec-test/tx/0C2A873B6952DF74868A1EEA3B7536BE40A49A25CA810B911FCAC5456CD1353D)  
```solidity
function AddLiquidity(uint tokenAmount) public payable {
    IERC20(myToken).safeTransferFrom(msg.sender, address(this),tokenAmount);
    IERC20(myToken).safeApprove(router, tokenAmount);
    IUniswapV2Router01(router).addLiquidityETH{value: msg.value}(myToken, tokenAmount, 0, 0, msg.sender, block.timestamp);
}
```
![withdraw](/W4-2/DATA/picture/withdraw.png)  