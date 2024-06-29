//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ErrorHandling {

  mapping(address => uint) public balances;

  function deposit(uint _amount) public {
    balances[msg.sender] += _amount;
  }

  function withdrawRequire(uint _amount) public {
    require(balances[msg.sender] >= _amount, "Insufficient balance");
    balances[msg.sender] -= _amount;
  }

  function withdrawAssert(uint _amount) public {
    assert(balances[msg.sender] >= _amount);
    balances[msg.sender] -= _amount;
  }

  function withdrawRevert(uint _amount) public {
    if(balances[msg.sender] < _amount) {
      revert("Insufficient balance");
    }
    balances[msg.sender] -= _amount;
  }

}
