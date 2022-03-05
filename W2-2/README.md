# W2_2作业：
* 编写合约Score，⽤于记录学⽣（地址）分数：
    * 仅有⽼师（⽤modifier权限控制）可以添加和修改学⽣分数
    * 分数不可以⼤于 100； 
* 编写合约Teacher 作为⽼师，通过 IScore 接⼝调⽤修改学⽣分数。

作业要求：
1. 使用自己的 github 创建一个作业代码库
2. 每一次作业使用一个文件夹(w1) 
3. 提交代码、截图、交易 hash 等

## 目录
* [编写合约Score](#编写合约Score) 
    * 仅有⽼师
    * 分数不可以⼤于100
* [编写合约Teacher](#编写合约Teacher) 

## 编写合约Score
hash:[6A14990337A6407D311642620B8CC5B85E833071631857A50977447D62D3B045](https://www.oklink.com/zh-cn/oec-test/tx/6A14990337A6407D311642620B8CC5B85E833071631857A50977447D62D3B045)  
sol_code:[class.sol](/W2-2/DATA/sol/class.sol)  
![class](/W2-2/DATA/picture/class.png)  
### 仅有⽼师
```solidity
modifier onlyTeacher() {
    require(S_Teacher[msg.sender],"Not Teacher");
    _;
}
```
### 分数不可以⼤于100
```solidity
function set_score(address _student,uint8 _score)external onlyTeacher{
    require(_score<=101,"score error");
    Student_score[_student]=_score;
}
```

## 编写合约Teacher
```solidity
contract Teacher {
    Score public this_Score;
    constructor(){
        this_Score = new Score();
    }
    function T_Iset_score(address _score_add,address _student,uint8 _score)external{
        IScore(_score_add).set_score(_student,_score);
    }
}
```