pragma solidity ^0.8.0;

contract InternalReentrancy {
    mapping(address => uint256) balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount);
        // Call the receiver's fallback function
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "Transfer failed.");
        balances[msg.sender] -= _amount;
    }

    function attack() public payable {
        // Call the withdraw function recursively
        (bool success, ) = address(this).call{value: msg.value}(
            abi.encodeWithSignature("withdraw(uint256)", msg.value)
        );
        require(success, "Attack failed.");
    }
}
