pragma solidity ^0.8.0;

contract BiasedRandomNumber {
    uint256 public randomSeed;
    
    function biasedRandomNumber() public returns (uint256) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, randomSeed)));
        randomSeed = randomNumber; // update seed for next call
        
        if (randomNumber % 2 == 0) {
            return 0; // return 0 half the time
        } else {
            return 1; // return 1 half the time
        }
    }
}

// This contract generates a random number using the keccak256 hash function 
// with a seed that includes the current timestamp and the sender's address. 
// However, the contract is biased because it returns 0 half the time and 1 half 
// the time, regardless of the seed or input parameters. This can be a serious 
// vulnerability if the random number is used to make important decisions or 
// allocate resources in the contract.