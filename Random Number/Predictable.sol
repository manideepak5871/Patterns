pragma solidity ^0.8.0;

contract PredictableRandomNumber {
    uint256 private seed;
    
    constructor(uint256 _seed) {
        seed = _seed;
    }
    
    function generateRandomNumber() public returns (uint256) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, seed))) % 100;
        seed = randomNumber;
        return randomNumber;
    }
}

// In this example, the random number is generated using the keccak256 hash function, 
// which takes the current block timestamp and a seed value as inputs. However, 
// because the timestamp is predictable and can be manipulated by miners, the 
// generated number can also be predicted and exploited by an attacker.