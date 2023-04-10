pragma solidity ^0.8.0;

contract ReentrancyExample {
    mapping(address => uint256) public balances;

    event Deposit(address indexed sender, uint256 value);
    event Withdrawal(address indexed sender, uint256 value);

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance");
        msg.sender.call{value: amount}("");
        balances[msg.sender] -= amount;
        emit Withdrawal(msg.sender, amount);
    }

    fallback() external payable {
        emit Deposit(msg.sender, msg.value);
    }
}
