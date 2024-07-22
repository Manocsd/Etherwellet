// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherWallet {
    address public owner;

    event Deposit(address indexed sender, uint256 amount);
    event Withdraw(address indexed receiver, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

      receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

       fallback() external payable {
        emit Deposit(msg.sender, msg.value);
    }

       function withdraw(uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount, "Insufficient balance");
        payable(msg.sender).transfer(_amount);
        emit Withdraw(msg.sender, _amount);
    }

       function transfer(address payable _to, uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount, "Insufficient balance");
        _to.transfer(_amount);
        emit Transfer(msg.sender, _to, _amount);
    }

        function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
