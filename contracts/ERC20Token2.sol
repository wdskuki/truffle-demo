pragma solidity ^0.4.0;

contract ERC20Token2{
  string private _name = 'Wei Dongsheng';
  string private _symbol = 'WDS';
  uint8 private _decimals = 0;
  uint256 private _totalSupply;
  address private _owner;

  mapping(address => uint256) private accounts;
  uint private buyPrice = 1000000000000000000;
  uint private sellPrice = 1000000000000000000;

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);


  constructor(uint256 totalSupply, string name, string symbol){
    _totalSupply = totalSupply;
    _owner = msg.sender;
    accounts[address(this)] = _totalSupply;
    _name = name;
    _symbol = symbol;
  }
  

   function name() constant returns (string) {
     return _name;
   }

   function symbol() constant returns (string) {
     return _symbol;
   }

   function decimals() constant returns (uint8){
     return _decimals;
   }

   function totalSupply() constant returns (uint256){
     return _totalSupply;
   }

   function balanceOf(address addr) constant returns (uint256){
     return accounts[addr];
   }

  // msg.sender调用transfer函数将自己的token转账给_to地址，_value为转账个数
  function transfer(address _to, uint256 _value) payable returns (bool){
    _transfer(msg.sender, _to, _value);
  }

  function _transfer(address _from, address _to, uint _value) internal{
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
  function buy() payable returns(bool){
    uint amount = msg.value / buyPrice;
    address(this).send(msg.value); 
    _transfer(address(this), msg.sender, amount);
    return true;
  }
  
  //出售tokens
  function sell(uint amount) returns (uint revenue){
    require(accounts[msg.sender] >= amount);         // checks if the sender has enough to sell
    accounts[address(this)] += amount;                        // adds the amount to owner's balance
    accounts[msg.sender] -= amount;                  // subtracts the amount from seller's balance
    revenue = amount * sellPrice;
    msg.sender.transfer(revenue);                     // sends ether to the seller: it's important to do this last to prevent recursion attacks
    Transfer(msg.sender, address(this), amount);               // executes an event reflecting on the change
    return revenue;                                   // ends function and returns
  }

  function getETHVal(address addr) constant returns(uint){
      return addr.balance;
  }
  
  function withDraw(uint amount) payable{
      if(msg.sender == _owner){
          _owner.send(amount);
      }else{
          assert(1 == 2);
      }
  }
}