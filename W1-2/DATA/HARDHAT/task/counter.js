// npx hardhat help counter
// npx hardhat counter --address 0x764617558a54bEEE86ab3AECA8Ac5a2DdDd8C8eD --network oktest

task("counter","prints current counter value")
.addParam("address","The counter's address")
.setAction(async (taskArgs)=>{
    const contractAddr = taskArgs.address;
    let counter =await ethers.getContractAt("Counter",contractAddr);

    let currValue = await counter.counter();
    console.log("current counter value:" + currValue);
})