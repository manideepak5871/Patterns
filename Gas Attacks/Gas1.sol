pragma solidity ^0.8.0;

contract GasLimitVulnerability {
    uint256[] public values;
    
    function addValue(uint256 value) public {
        // gas limit vulnerability here
        require(gasleft() >= 100000, "Not enough gas to execute");
        
        values.push(value);
    }
    
    function getValues() public view returns (uint256[] memory) {
        return values;
    }
}
// In this example, the addValue function adds a new value to the values array. 
// However, it includes a vulnerability where the contract is assuming that the 
// caller has provided enough gas to execute the function.