const { artifacts } = require("hardhat");
const hre = require("hardhat");
const { writeAbiAddr } = require('./artifact_log.js');

const ERC2612Addr = require(`../deployments/${network.name}/ERC2612.json`)
async function main() {
  const Vault = await hre.ethers.getContractFactory("Vault");
  const vault = await Vault.deploy(ERC2612Addr.address);
  await vault.deployed();
  console.log("Vault deployed to:", vault.address);
  let Artifact = await artifacts.readArtifact("Vault");
  await writeAbiAddr(Artifact,vault.address, "Vault", network.name);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
