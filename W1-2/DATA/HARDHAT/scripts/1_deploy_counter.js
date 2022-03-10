const { artifacts, network } = require("hardhat");
const hre = require("hardhat");
// const {writeAbiAddr} =require(./artifact_saver.js);

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Counter = await hre.ethers.getContractFactory("Counter");
  const counter = await Counter.deploy(20);
  await counter.deployed();
  console.log("Counter deployed to:", counter.address);


  let Artifact = await artifacts.readArtifact("Counter");
  console.log("data:", Artifact,counter.address,"Counter",network.name);
  // await writeAbiaddr(Artifact,counter.address,"Counter",network.name);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
