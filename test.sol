// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public name = "My Token";
    string public symbol = "MTK";
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed account, uint256 value);
    event Burn(address indexed account, uint256 value);

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * 10 ** 18; // 18 decimal places
        balanceOf[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    function transfer(address to, uint256 value) public {
        require(to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);
    }

    function mint(address account, uint256 amount) public onlyOwner {
        require(account != address(0), "Invalid address");

        totalSupply += amount;
        balanceOf[account] += amount;

        emit Mint(account, amount);
    }

    function burn(address account, uint256 amount) public onlyOwner {
        require(account != address(0), "Invalid address");
        require(balanceOf[account] >= amount, "Insufficient balance");

        totalSupply -= amount;
        balanceOf[account] -= amount;

        emit Burn(account, amount);
    }
}
