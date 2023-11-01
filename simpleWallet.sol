// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract simpleWallet {
    uint256 public totalSupply;
    mapping(address => uint256) public balances;

    event Mint(address indexed to, uint256 value);

    function mint(address _to, uint256 _value) public {

        assert(_value > 10);
        totalSupply += _value;
        balances[_to] += _value;
        emit Mint(_to, _value);
    }

    function deposit(uint256 amount) public payable {

        require(amount >= 10, "The amount must be greater than 10");
        uint256 newBalance = balances[msg.sender] + msg.value;
        require(newBalance >= balances[msg.sender], "Overflow detected");
        balances[msg.sender] = newBalance;
    }

    function burn(uint256 _value) public {

    if (_value < 10) {
        revert("Value must be greater than or equal to 10");
    }

    require(balances[msg.sender] >= _value, "Insufficient balance");
    totalSupply -= _value;
    balances[msg.sender] -= _value;
    }
}
