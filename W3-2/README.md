# W3_2作业
* 发行一个ERC721Token
   * 使用ether.js解析ERC721转账事件(加分项：记录到数据库中，可方便查询用户持有的所有NFT)
   * (或)使用TheGraph解析ERC721转账事件

## 目录
* [发行一个ERC721Token](#发行一个ERC721Token) 
    * [使用ether.js解析ERC721转账事件](#使用ether.js解析ERC721转账事件) 
        * [记录到数据库中](#记录到数据库中) 
    * [使用TheGraph解析ERC721转账事件](#使用TheGraph解析ERC721转账事件) 

## 发行一个ERC721Token
hash:[D9884866D9882264EF6C85802C4E9BD368681242F6DFA5A7AB47469C8FDF7D0D](https://www.oklink.com/zh-cn/oec-test/tx/D9884866D9882264EF6C85802C4E9BD368681242F6DFA5A7AB47469C8FDF7D0D)  
sol_code:[MyERC721.sol](/W3-2/DATA/code/contracts/MyERC721.sol)  
![MyERC721](/W3-2/DATA/picture/MyERC721.png)  

## 使用ether.js解析ERC721转账事件
hash:[4377C769C6141EF50961DE57D854A5A7C87499F8936B4D4F4C4732826930FC77](https://www.oklink.com/zh-cn/oec-test/tx/4377C769C6141EF50961DE57D854A5A7C87499F8936B4D4F4C4732826930FC77)  
js_code:[listen_event.js](/W3-2/DATA/code/scripts/listen_event.js)  
![listen_event](/W3-1/DATA/picture/listen_event.png)  
### 记录到数据库中
```JavaScript
const mysql = require("mysql");
const conn = mysql.createConnection(require("/home/learn/secret/W3-2/online-mysql.json"));
conn.connect();
conn.query("INSERT INTO erc721_Adeceitz(blockNumber,transactionHash,fromadd,toadd,tokenid) VALUES(?,?,?,?,?)"
,[event.blockNumber,event.transactionHash,decodedData.args.from,decodedData.args.to,decodedData.args.tokenId.toString()], function (err, result) {
    if (err) {
        console.log('[INSERT ERROR] - ', err.message);
        return;
    }
});
conn.end();
```
![SQL](/W3-1/DATA/picture/SQL.png)  

## 使用TheGraph解析ERC721转账事件