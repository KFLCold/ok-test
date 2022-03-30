# W5_2作业
* 在一笔交易中完成（模拟闪电贷交易）
   * 在AAVE中借款tokenA
   * 使用tokenA在UniswapV2中交易兑换tokenB，然后在UniswapV3tokenB兑换为tokenA
   * tokenA还款给AAVE

作业要求：
1. 使用自己的 github 创建一个作业代码库
2. 每一次作业使用一个文件夹(w1) 
3. 提交代码、截图、交易 hash 等

## 目录
* [在一笔交易中完成（模拟闪电贷交易）](#在一笔交易中完成（模拟闪电贷交易）) 
* [通过Metamask向Bank合约转账ETH](#通过Metamask向Bank合约转账ETH) 
* [在Bank合约记录每个地址转账⾦额](#在Bank合约记录每个地址转账⾦额) 
* [编写Bank合约withdraw(),实现提取出所有的ETH](#编写Bank合约withdraw(),实现提取出所有的ETH) 

## 在一笔交易中完成闪电贷交易
### 使用tokenA在UniswapV2中交易兑换tokenB
### tokenA还款给AAVE
hash:[DBAB5766B042A56F2C996AE57B224F39B78D61B8266691CE08DC0D38926C5E39](https://www.oklink.com/zh-cn/oec-test/tx/DBAB5766B042A56F2C996AE57B224F39B78D61B8266691CE08DC0D38926C5E39)  
sol_code:[Bank.sol](/W2-1/DATA/Bank/Bank.sol)  
![Bank](/W2-1/DATA/picture/Bank.png)  
