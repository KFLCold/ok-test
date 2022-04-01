# W5_1作业
* 以太坊测试网上部署两个自己的ERC20合约MyToken，分别在Uniswap V2、V3(网页上)添加流动性
* 作业：编写合约执行闪电贷（参考V2的ExampleFlashSwap）：
   * uniswapV2Call中，用收到的 TokenA 在 Uniswap V3 的 SwapRouter 兑换为 TokenB 还回到 uniswapV2 Pair 中。

作业要求：
1. 使用自己的 github 创建一个作业代码库
2. 每一次作业使用一个文件夹(w1) 
3. 提交代码、截图、交易 hash 等

## 目录
* [以太坊测试网上部署两个自己的ERC20合约MyToken](#以太坊测试网上部署两个自己的ERC20合约MyToken) 
    * [在UniswapV2添加流动性](#在UniswapV2添加流动性) 
    * [在UniswapV3添加流动性](#在UniswapV3添加流动性) 
* [编写合约执行闪电贷](#编写合约执行闪电贷) 

## 以太坊测试网上部署两个自己的ERC20合约MyToken
TOKENA：0x335646DF51725a4050400641109169D30d65D587
hash:[0x8800f64a1a7c9913615cc90946e33aea3e935233048ce3748d304f4e3d3aeb25](https://rinkeby.etherscan.io/tx/0x8800f64a1a7c9913615cc90946e33aea3e935233048ce3748d304f4e3d3aeb25)  
TOKENB：0xa6429334BA49d01fDdFE3161e7f781ed351A7cDC
hash:[0x04e09b4788fb17d3bc8e25bc8b89a23311d0001519d981b9d54367a582e63bb7](https://rinkeby.etherscan.io/tx/0x04e09b4788fb17d3bc8e25bc8b89a23311d0001519d981b9d54367a582e63bb7) 

### 在UniswapV2添加流动性
TOKENA:TOKENB=1:2
V2pair:0x31E3c6Fbf52937D0d339f10D382b950f9160Af12
V2router:0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
hash:[0x4c90cd927a908d66688b5d7b9c0966c3b4aa600759a2a57042118ee3abb23af1](https://rinkeby.etherscan.io/tx/0x4c90cd927a908d66688b5d7b9c0966c3b4aa600759a2a57042118ee3abb23af1)  

### 在UniswapV3添加流动性
TOKENA:TOKENB=2:1
V3pair:0xF5dbA747a8489Bd27816f432bBa3eEcA1519FAF0
V3router:0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45
hash:[0xffb83b53626e3737b3994e64617a25929ce2ffa44b2859a0a57a6957cadda30a](https://rinkeby.etherscan.io/tx/0xffb83b53626e3737b3994e64617a25929ce2ffa44b2859a0a57a6957cadda30a)  

## 编写合约执行闪电贷
### 用收到的 TokenA 在 Uniswap V3 的 SwapRouter 兑换为 TokenB 还回到 uniswapV2 Pair 中
hash:[0xa37835c4ae492846b5f6df5953f6b00771bd96fbf07e59f5947bb33b6cfb1ec9](https://rinkeby.etherscan.io/tx/0xa37835c4ae492846b5f6df5953f6b00771bd96fbf07e59f5947bb33b6cfb1ec9)
sol_code:[uniswapV2Call.sol](/W5-1/DATA/sol/uniswapV2Call.sol)    
![uniswapV2Call](/W5-1/DATA/picture/uniswapV2Call.png)  
