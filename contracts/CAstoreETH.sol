pragma solidity ^0.4.0;

contract CAstoreETH{

  mapping(address => uint) accounts;
  
  //获得各个账户的ETH充值余额
  function getAccounts(address addr) constant returns (uint){
    return accounts[addr];
  }

  //获得CA中的ETH余额
  function getBalance() constant returns (uint){
    return this.balance;
  }

  //EOA向CA充值
  function deposit() payable {  
    address(this).send(msg.value);
    accounts[msg.sender] += msg.value;
  }
}
