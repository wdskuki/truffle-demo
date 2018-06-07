pragma solidity ^0.4.0;

contract CAstoreToken{

  address owner; //合约发起人
  uint totalTokens; //代币总量
  mapping(address => uint) accounts; //各个账户的代币量
  

  //初始化
  constructor(uint amount) {
    owner = msg.sender;
    totalTokens = amount;
  }

  //EOA向CA所要代币值
  function send(uint value) {
    if(accounts[msg.sender] == 0){
      totalTokens -= value;
      accounts[msg.sender] = value;
    }else{
      totalTokens += value;
      accounts[msg.sender] = 0;
    }
  }


  function getResult(address addr) constant returns(uint, uint){
      return (totalTokens, accounts[addr]);
  }
}
