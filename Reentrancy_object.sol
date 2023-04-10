pragma solidity ^0.8.0;

contract ReentrancyExample {
    mapping(address => uint256) private balances;

    event Deposit(address indexed sender, uint256 value);
    event Withdrawal(address indexed sender, uint256 value);

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance");
        Withdrawer withdrawer = new Withdrawer(msg.sender, amount);
        withdrawer.execute();
        balances[msg.sender] -= amount;
        emit Withdrawal(msg.sender, amount);
    }

    function getBalance(address account) public view returns (uint256) {
        return balances[account];
    }

    class Withdrawer {
        address private user;
        uint256 private amount;
        bool private locked;

        constructor(address _user, uint256 _amount) {
            user = _user;
            amount = _amount;
            locked = false;
        }

        function execute() public {
            require(!locked, "Function is locked");
            locked = true;
            (bool success,) = user.call{value: amount}("");
            require(success, "Transfer failed");
            locked = false;
        }
    }
}
