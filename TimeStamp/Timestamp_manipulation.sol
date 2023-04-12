pragma solidity ^0.8.0;

contract TimestampManipulation {
    uint256 public deadline = block.timestamp + 1 minutes;
    uint256 public reward = 1 ether;
    address public winner;
    
    function claimReward() external {
        require(block.timestamp >= deadline, "Deadline not yet reached");
        require(msg.sender != winner, "Reward already claimed");
        winner = msg.sender;
        payable(msg.sender).transfer(reward);
    }
}
