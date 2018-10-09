pragma solidity ^0.4.0;

//请注意这个仅是Demo，请不要用到正式环境
contract SimpleDepositAndWithDraw {
    address owner;
    constructor(){
        owner = msg.sender;
    }
    //得到当前合约的余额
    function getBalance() constant returns (uint) {
        return this.balance;//0
    }

    //向当前合约存款
    function deposit() payable {
        //msg.sender 全局变量，调用合约的发起方
        //msg.value 全局变量，调用合约的发起方转发的货币量，以wei为单位。
        //send() 执行的结果
        address(this).send(msg.value);
    }

    function withdraw(uint value) payable {
        if(owner == msg.sender){
            owner.send(value);
        }else{
            assert(1 == 2);
        }
    }
}
