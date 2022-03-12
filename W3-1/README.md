# W3_1作业
* 发⾏⼀个ERC20Token：
  * 可动态增发（起始发⾏量是0）
  * 通过ethers.js.调⽤合约进⾏转账
* 编写⼀个Vault合约：
  * 编写deposite⽅法，实现ERC20存⼊Vault，并记录每个⽤户存款⾦额，⽤从前端调⽤（Approve，transferFrom）
  * 编写withdraw⽅法，提取⽤户⾃⼰的存款（前端调⽤）
  * 前端显示⽤户存款⾦额

作业要求：
1. 使用自己的 github 创建一个作业代码库
2. 每一次作业使用一个文件夹(w1) 
3. 提交代码、截图、交易 hash 等

## 目录
* [发⾏⼀个ERC20Token：](#发⾏⼀个ERC20Token：)
  * [可动态增发](#可动态增发)
  * [通过ethers.js.调⽤合约进⾏转账](#通过ethers.js.调⽤合约进⾏转账)
* [编写⼀个Vault合约：](#编写⼀个Vault合约：) 
  * [编写deposite⽅法](#编写deposite⽅法)
  * [编写withdraw⽅法](#编写withdraw⽅法)
  * [前端显示⽤户存款⾦额](#前端显示⽤户存款⾦额)

## 发⾏⼀个ERC20Token：
hash:[3922FE276E01E84E44616A1343FCE16ED8C602180F258141B4E2B4088F838B8D](https://www.oklink.com/zh-cn/oec-test/tx/3922FE276E01E84E44616A1343FCE16ED8C602180F258141B4E2B4088F838B8D)  
sol_code:[MyERC20.sol](/W3-1/DATA/w3_code/contracts/ERC2612.sol)  
![MyERC20](/W3-1/DATA/picture/ERC2612.png)  
### 可动态增发
```solidity
contract ERC2612 is ERC20,ERC20Permit {
    constructor() ERC20("ADRCEITZ", "ADRCEITZ") ERC20Permit("ERC2612") {
        // _mint(msg.sender, 1000 * 10 ** 18);
    }
    function mint(address recipient,uint amount)external returns(bool){
        _mint(recipient,amount);
        return true;
    }
}
```
### 通过ethers.js.调⽤合约进⾏转账
hash:[0F3C2BF90616767557543FD54438BF3AD1B115A3A0969D6B820C65FAC850FCA6](https://www.oklink.com/zh-cn/oec-test/tx/0F3C2BF90616767557543FD54438BF3AD1B115A3A0969D6B820C65FAC850FCA6)  
js_code:[oktest_ethers_transfer.js](/W3-1/DATA/w3_code/scripts/oktest_ethers_transfer.js)  
![ethers_transfer](/W3-1/DATA/picture/ethers_transfer.png)  
```JavaScript
const { ethers, network } = require("hardhat");
const ERC20Addr = require(`../deployments/${network.name}/ERC2612.json`)
async function main() {
    let [owner, second] = await ethers.getSigners();
    let ERC2612 = await ethers.getContractAt("ERC2612",
        ERC20Addr.address,
        owner);
    let info = await ERC2612.mint(owner.address, ethers.utils.parseEther("100"));
    console.log("mint_hash:",info.hash);
    info = await ERC2612.transfer(second.address, ethers.utils.parseEther("10"));
    console.log("transfer_hash:",info.hash);
}
```

## 编写⼀个Vault合约：
hash:[F17551AE1AD6A7CD69A81E0E865EA9B350F32EA4C8A5911C39A5A0CB6EA205CA](https://www.oklink.com/zh-cn/oec-test/tx/F17551AE1AD6A7CD69A81E0E865EA9B350F32EA4C8A5911C39A5A0CB6EA205CA)  
sol_code:[Vault.sol](/W3-1/DATA/w3_code/contracts/Vault.sol)  
![Vault](/W3-1/DATA/picture/Vault.png)  
### 编写deposite⽅法
```solidity
function deposit(address user,uint256 amount)public{
    require(IERC20(token).transferFrom(msg.sender, address(this), amount), "Transfer from error");
    deposited[user]+=amount;
}
```
approve_hash:[BDBE6E1CFA49BE1FB0C230F82E9A16CBE84E258C9B645116DE36449428638815](https://www.oklink.com/zh-cn/oec-test/tx/BDBE6E1CFA49BE1FB0C230F82E9A16CBE84E258C9B645116DE36449428638815)  
![approve](/W3-1/DATA/picture/approve.png)  
deposite_hash:[C98CEDDF63A1384BD09415E8D56249C2DD87BCCF6D31FD5D6E657D24CC537D44](https://www.oklink.com/zh-cn/oec-test/tx/C98CEDDF63A1384BD09415E8D56249C2DD87BCCF6D31FD5D6E657D24CC537D44)  
![deposite](/W3-1/DATA/picture/deposite.png)  
### 编写withdraw⽅法
```solidity
function withdraw(address user,uint256 amount)public{
    deposited[msg.sender]-=amount;
    IERC20(token).transfer(user,amount);
}
```
hash:[6473596D19BCFFC553D60B2C7E1D2AE252F1726024D400EAAFF4553A4AA35896](https://www.oklink.com/zh-cn/oec-test/tx/6473596D19BCFFC553D60B2C7E1D2AE252F1726024D400EAAFF4553A4AA35896)  
![withdraw](/W3-1/DATA/picture/withdraw.png)
### 前端显示⽤户存款⾦额
![amount](/W3-1/DATA/picture/amount.png)