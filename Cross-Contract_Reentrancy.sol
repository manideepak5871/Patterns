pragma solidity ^0.8.0;

interface ITarget {
    function withdraw(uint256 _amount) external;
}

contract CrossContractReentrancy {
    mapping(address => uint256) balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        // Call the receiver's withdraw function
        ITarget(msg.sender).withdraw(_amount);
    }

    function attack(address _target) public payable {
        // Call the withdraw function of the target contract recursively
        ITarget(_target).withdraw(msg.value);
    }
}
