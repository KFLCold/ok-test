const { ethers, network } = require("hardhat");
const ERC20Addr = require(`../deployments/${network.name}/MyERC721.json`)
const mysql = require("mysql");

const conn = mysql.createConnection(require("/home/learn/secret/W3-2/online-mysql.json"));
async function parseMintEvent(event) {
    const MintEvent = new ethers.utils.Interface(["event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);"]);
    let decodedData = MintEvent.parseLog(event);
    console.log("from:" + decodedData.args.from);
    console.log("to:" + decodedData.args.to);
    console.log("tokenId:" + decodedData.args.tokenId.toString());
    conn.connect();
    conn.query("INSERT INTO erc721_Adeceitz(blockNumber,transactionHash,fromadd,toadd,tokenid) VALUES(?,?,?,?,?)"
    ,[event.blockNumber,event.transactionHash,decodedData.args.from,decodedData.args.to,decodedData.args.tokenId.toString()], function (err, result) {
        if (err) {
            console.log('[INSERT ERROR] - ', err.message);
            return;
        }
    });
    conn.end();
}
async function main() {
    console.log("loading.....");
    let [owner, second] = await ethers.getSigners();
    let myerc721 = await ethers.getContractAt("MyERC721",
        ERC20Addr.address,
        owner);

    let filter = myerc721.filters.Transfer()
    ethers.provider.on(filter, (event) => {
      console.log(event)
        parseMintEvent(event);
    })
}

main()