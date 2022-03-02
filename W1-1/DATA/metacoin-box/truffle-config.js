const HDWalletProvider = require('@truffle/hdwallet-provider');
const fs = require('fs');
const mnemonic =fs.readFileSync("/home/learn/.secret").toString().trim();

module.exports = {
  compilers:{
    solc:{
      version:"0.8.9",
    }
  },
  networks: {
   development: {
     host: "127.0.0.1",
     port: 7545,
     network_id: "*"
   },
   test: {
     host: "127.0.0.1",
     port: 7545,
     network_id: "*"
   },
   oktest:{
     provider:()=> new HDWalletProvider(mnemonic,"https://exchaintestrpc.okex.org"),
      network_id: 65,
      gas: 5500000,
      confirmation:2,
      timeoutBlocks: 200,
      skipDryRun: true
   }
  },
  // db: {
    // enabled: false,
    // host: "127.0.0.1",
    // adapter: {
    //   name: "sqlite",
    //   settings: {
    //     directory: ".db"
    //   }
    // }
  // }
};
