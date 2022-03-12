// npx hardhat run ./scripts/transfer.js --network oktest

const { ethers, network } = require("hardhat");
// const delay = require('./delay');

const ERC20Addr = require(`../deployments/${network.name}/MyERC20.json`)

async function main() {

    let [owner, second] = await ethers.getSigners();
    let MyERC20 = await ethers.getContractAt("MyERC20",
        ERC20Addr.address,
        owner);

    let info = await MyERC20.mint(owner.address, 1000);
    console.log("mint_hash:",info.hash);
    info = await MyERC20.transfer(second.address, 1000);
    console.log("transfer_hash:",info.hash);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });


  // duration = 60;
  // await delay.advanceTime(ethers.provider, duration); 
  // await delay.advanceBlock(ethers.provider);