// npx hardhat run ./scripts/ERC721_mint.js --network oktest
const { ethers, network } = require("hardhat");
const ERC20Addr = require(`../deployments/${network.name}/MyERC721.json`)
async function main() {
    let [owner] = await ethers.getSigners();
    let MyERC721 = await ethers.getContractAt("MyERC721",
        ERC20Addr.address,owner);
    let info = await MyERC721.safeMint(owner.address);
    console.log("mint_hash:",info.hash);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });