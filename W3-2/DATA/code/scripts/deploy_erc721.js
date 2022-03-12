const hre = require("hardhat");
const { writeAddr } = require('./artifact_log.js');

async function main() {
  // await hre.run('compile');

  const MyERC721 = await hre.ethers.getContractFactory("MyERC721");
  const token = await MyERC721.deploy();

  await token.deployed();

  console.log("MyERC721 deployed to:", token.address);
  await writeAddr(token.address, "MyERC721", network.name)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
