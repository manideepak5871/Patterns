pragma solidity ^0.8.0;

contract GasLimitVuln {
    uint256 public count;
    
    function increaseCount() public {
        for (uint256 i = 0; i < 10; i++) {
            count += i;
        }
    }
}


// In this example, the increaseCount function includes a loop 
// that runs 10 times, increasing the count variable by the value 
// of i on each iteration. If the gas limit set by the user is too low, 
// it may not be enough to complete all 10 iterations of the loop. 
// This can result in the transaction running out of gas before the loop completes, 
// causing it to fail and resulting in the loss of any gas spent on the transaction.