// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.8.7;
contract Score {
    constructor(){
        S_Teacher[msg.sender]=true;
    }
    mapping(address=>bool) public S_Teacher;
    modifier onlyTeacher() {
        require(S_Teacher[msg.sender],"Not Teacher");
        _;
    }

    mapping(address=>uint8) public Student_score;
    function set_score(address _student,uint8 _score)external onlyTeacher{
        require(_score<=101,"score error");
        Student_score[_student]=_score;
    }
    function C_Teacher(address _Teacher,bool flag)external onlyTeacher{
        S_Teacher[_Teacher]=flag;
    }
}
interface IScore{
    function set_score(address _student,uint8 _score)external;
}
contract Teacher {
    Score public this_Score;
    constructor(){
        this_Score = new Score();
    }
    function T_Iset_score(address _score_add,address _student,uint8 _score)external{
        IScore(_score_add).set_score(_student,_score);
    }
}