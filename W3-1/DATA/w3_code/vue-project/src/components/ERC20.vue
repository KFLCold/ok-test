<script>
import { ethers } from 'ethers'

import ERC2612Addr from '../../../deployments/oktest/ERC2612.json'
import ERC2612Abi from '../../../deployments/abi/ERC2612.json'

import vaultAddr from '../../../deployments/oktest/Vault.json'
import vaultAbi from '../../../deployments/abi/Vault.json'

import { premitTypedDate } from "../typedData.js";

export default {

  name: 'erc20',

  data() {
    return {

      recipient: null,
      amount: null,
      balance: null,

      name: null,
      decimal: null,
      symbol: null,
      supply: null,

      stakeAmount: null,

      vaultaddress: null,
      useradd: null,
      vaultbalance: null,
      approvebalance: null,
    }
  },

  async created() {
    await this.initAccount()
    this.initContract()
    this.getInfo();
    this.getNonce();
  },

  methods: {
    async initAccount(){
      if(window.ethereum) {
        console.log("initAccount");
        try{
          this.accounts = await window.ethereum.enable()
          console.log("accounts:" + this.accounts);
          this.account = this.accounts[0];
          this.currProvider = window.ethereum;
          this.provider = new ethers.providers.Web3Provider(window.ethereum);

          this.signer = this.provider.getSigner()
          let network = await this.provider.getNetwork()
          this.chainId = network.chainId;
          console.log("chainId:", this.chainId);

        } catch(error){
          console.log("User denied account access", error)
        }
      }else{
        console.log("Need install MetaMask")
      }
    },

    async initContract() {
      this.erc20Token = new ethers.Contract(ERC2612Addr.address, 
        ERC2612Abi.abi, this.signer);

      this.vault = new ethers.Contract(vaultAddr.address, 
        vaultAbi.abi, this.signer);

    }, 

    getInfo() {
      this.erc20Token.name().then((r) => {
        this.name = r;
      })
      this.erc20Token.decimals().then((r) => {
        this.decimal = r;
      })
      this.erc20Token.symbol().then((r) => {
        this.symbol = r;
      })
      this.erc20Token.totalSupply().then((r) => {
        this.supply = ethers.utils.formatUnits(r, 18);
      })

      this.erc20Token.balanceOf(this.account).then((r) => {
        this.balance = ethers.utils.formatUnits(r, 18);
      })
      this.vault.deposited(this.account).then((r)=>{
        this.vaultbalance = ethers.utils.formatUnits(r, 18);
      })
      this.vaultaddress = vaultAddr.address;
      this.useradd = this.account;

      this.erc20Token.allowance(this.account,vaultAddr.address).then((r)=>{
        this.approvebalance = ethers.utils.formatUnits(r, 18);
      })
    },

    getNonce() {
      this.erc20Token.nonces(this.account).then(r => {
        this.nonce = r.toString();
        console.log("nonce:" + this.nonce);
      })
    },

    transfer() {
      let amount = ethers.utils.parseUnits(this.amount, 18);
      this.erc20Token.transfer(this.recipient, amount).then((r) => {
        console.log(r);  // 返回值不是true
        this.getInfo();
      })
    },

    permitStake() {
      this.deadline = Math.ceil(Date.now() / 1000) + parseInt(20 * 60);
      
      let amount =  ethers.utils.parseUnits(this.stakeAmount).toString();
      

      let msgParams = premitTypedDate("ERC2612", 
        ERC2612Addr.address,
        this.account, vaultAddr.address, amount, this.deadline, this.chainId, this.nonce);
      
      console.log("msgParams:" + msgParams)

      this.currProvider.sendAsync({
        method: 'eth_signTypedData_v4',
        params: [this.account, msgParams],
        from: this.account
      }, (err, sign) => {
        this.sign = sign.result;
        console.log(this.sign)

        //  椭圆曲线签名签名的值:
        // r = 签名的前 32 字节
        // s = 签名的第2个32 字节
        // v = 签名的最后一个字节

        let r = '0x' + this.sign.substring(2).substring(0, 64);
        let s = '0x' + this.sign.substring(2).substring(64, 128);
        let v = '0x' + this.sign.substring(2).substring(128, 130);

        this.vault.permitDeposit(this.account, amount, this.deadline, v, r, s, {
                from: this.account
              }).then(() => {
                this.getInfo();
                this.getNonce();
            })
      });
    },
    deposit(){
      let amount = ethers.utils.parseUnits(this.stakeAmount, 18);
      this.vault.deposit(this.account,amount).then((r)=>{
        console.log(r);  // 返回值不是true
        this.getInfo();
      })
    },
    mint(){
      let amount = ethers.utils.parseUnits(this.amount, 18);
      this.erc20Token.mint(this.recipient, amount).then((r) => {
        console.log(r);  // 返回值不是true
        this.getInfo();
      })
    },
    withdraw(){
      let amount = ethers.utils.parseUnits(this.stakeAmount, 18);
      this.vault.withdraw(this.account,amount).then((r)=>{
        console.log(r);  // 返回值不是true
        this.getInfo();
      })
    },
    approve(){
      let amount = ethers.utils.parseUnits(this.amount, 18);
      this.erc20Token.approve(this.recipient, amount).then((r) => {
        console.log(r);  // 返回值不是true
        this.getInfo();
      })
    }
  }
}


</script>

<template>
  <div >

    <div>
      <br /> Token名称 : {{ name  }}
      <br /> Token符号 : {{  symbol }}
      <br /> Token精度 : {{  decimal }}
      <br /> Token发行量 : {{  supply }}
      <br /> 我的余额 : {{ balance  }}
    </div>

    <div >
      <br />地址
      <input type="text" v-model="recipient" />
      <br />金额
      <input type="text" v-model="amount" />
      <br />
      <button @click="mint()"> 挖矿mint </button>
      <button @click="approve()"> 授权approve </button>
      <button @click="transfer()"> 转账transfer </button>
    </div>

    <div>
      <br />{{ name  }}存款合约:{{vaultaddress}}
      <br />当前储户：{{ useradd }}
      <br />存款数量： {{  vaultbalance }}
      <br />当前储户approve授权合约数量：{{ approvebalance}}
    </div>

    <div >
      <input v-model="stakeAmount" placeholder="输入质押量"/>
      <br />
      <button @click="deposit()">授权存款deposit</button>
      <br />
      <button @click="permitStake()">离线授权存款permitDeposit</button>
      <br />
      <button @click="withdraw()">提款withdraw</button>
    </div>

  </div>
</template>

<style scoped>
h1 {
  font-weight: 500;
  font-size: 2.6rem;
  top: -10px;
}

h3 {
  font-size: 1.2rem;
}

.greetings h1,
.greetings h3 {
  text-align: center;
}

div {
  font-size: 1.2rem;
}

@media (min-width: 1024px) {
  .greetings h1,
  .greetings h3 {
    text-align: left;
  }
}
</style>
