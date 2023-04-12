pragma solidity ^0.8.0;

contract TimestampDependency {
    mapping(address => uint256) balances;
    uint256 deadline;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        require(block.timestamp >= deadline);
        uint256 amount = balances[msg.sender];
        require(amount > 0);
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed.");
    }

    function setDeadline(uint256 _deadline) public {
        deadline = _deadline;
    }
}
