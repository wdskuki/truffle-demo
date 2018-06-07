pragma solidity ^0.4.0;

contract ERC20Token{
  string NAME = 'Wei Dongsheng';
  string SYMBOL = 'WDS';
  uint8 DECIMALS = 0;

  address private _owner;

  uint256 totalTokens;
  mapping(address => uint256) accounts;

  uint buyPrice = 1;

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);


  constructor(uint256 initialSupply, string tokenName, string tokenSymbol){
    totalTokens = initialSupply;
    _owner = msg.sender;
    accounts[_owner] = totalTokens;
    NAME = tokenName;
    SYMBOL = tokenSymbol;
  }

   function name() constant returns (string) {
     return NAME;
   }

   function symbol() constant returns (string) {
     return SYMBOL;
   }

   function decimals() constant returns (uint8){
     return DECIMALS;
   }

   function totalSupply() constant returns (uint256){
     return totalTokens;
   }

   function balanceOf(address addr) constant returns (uint256){
     return accounts[addr];
   }

  // msg.sender调用transfer函数将自己的token转账给_to地址，_value为转账个数
  function transfer(address _to, uint256 _value) returns (bool){
      _transfer(msg.sender, _to, _value);
  }

  function _transfer(address _from, address _to, uint _value) {
    require(_to != 0x0);
    require(accounts[_from] >= _value);
    require(accounts[_to] + _value > accounts[_to]);
    uint previousBalances = accounts[_from] + accounts[_to];
    accounts[_from] -= _value;
    accounts[_to] += _value;
    Transfer(_from, _to, _value);
    assert(accounts[_from] + accounts[_to] == previousBalances);
  }

  //购买tokens
  function _buy() payable returns(bool){
    // uint amount = msg.value;
    _owner.send(msg.value); 
    _transfer(_owner, msg.sender, msg.value);
    return true;
  }
}