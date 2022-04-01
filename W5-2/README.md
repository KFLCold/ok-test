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

## 在一笔交易中完成（模拟闪电贷交易）
DAI:0xf80A32A835F79D7787E8a8ee5721D0fEaFd78108  
USDT=0xF976314868f3a1bA572D3ecb133209cD7e0d5aAE  
v2pair=0x0e4aD53B83f5E8a3F5717B15a613dA7E39B08715  
v3pair=0x539F1ac190907c132a8b225129eDc4513Be379Ac  
v2router=0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D  
v3router=0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45  

hash:[0x7c6b6f8fe1be90395eae657e8b5a82838833006419ddfe9182b74c41bbe82d3e](https://ropsten.etherscan.io/tx/0x7c6b6f8fe1be90395eae657e8b5a82838833006419ddfe9182b74c41bbe82d3e)  
sol_code:[Flashloan.sol](/W2-1/DATA/flashloan/contracts/Flashloan.sol)  
![Flashloan](/W2-1/DATA/picture/Flashloan.png)  
