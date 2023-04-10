pragma solidity ^0.8.0;

contract GasLimitVulnerabilityPattern2 {
    uint public withdrawAmount;
    
    function withdraw() public {
        require(msg.sender == 0x1234567890123456789012345678901234567890);
        uint amount = withdrawAmount;
        withdrawAmount = 0;
        (bool success,) = msg.sender.call{value: amount, gas: gasleft()}("");
        require(success, "Transfer failed.");
    }
    
    function deposit() public payable {}
    
    function setWithdrawAmount(uint amount) public {
        withdrawAmount = amount;
    }
}

// In this pattern, the withdraw() function uses the gasleft() function 
// to determine how much gas is available and then passes that 
// amount to the external contract call. This can lead to a 
// denial-of-service attack if the attacker calls the withdraw() function
// with a small amount of gas, causing the external call to fail and 
// preventing any future withdrawals from succeeding.