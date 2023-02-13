pragma solidity ^0.8.6;

contract Bank {

    mapping(address => uint)balance;

    address owner;

    event balanceAdded( uint amount, address depoitedTo);


    modifier onlyOwner{

          require(msg.sender  ==  owner)
          _;
    }

    constructor(){

    owner =msg.sender;

    }

    function addBalance(uint _toAdd)public returns (uint) onlyOwner{
        balance[msg.sender] += _toAdd;
        emit balanceAdded(_toAdd,msg.sender);
        return balance[msg.sender];
    }
    function getBalance()public view returns(uint){
        return balance[msg.sender];
    }
    function transfer(address recipient, uint amount)public onlyOwner{
       
        require(balance[msg.sender] >= amount,"you dont have enough balance to send")
           require(msg.sender!= recipient )

           uint previousSenderBalance = balance[msg.sender]

        balance[msg.sender] -= amount;
        balance[recipient] += amount;

        assert(balance[msg.sender] == previousSenderBalance - amount)
    }
}