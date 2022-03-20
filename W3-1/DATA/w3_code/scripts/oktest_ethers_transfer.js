// npx hardhat run ./scripts/transfer.js --network oktest
const { ethers, network } = require("hardhat");
// const delay = require('./delay');

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

main()
.then(() => process.exit(0))
.catch(error => {
    console.error(error);
    process.exit(1);
});


//   duration = 60;
//   await delay.advanceTime(ethers.provider, duration);
//   await delay.advanceBlock(ethers.provider);