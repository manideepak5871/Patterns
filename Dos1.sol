pragma solidity ^0.8.0;

contract DoS {
    uint[] public values;
    
    function add(uint value) public {
        values.push(value);
    }
    
    function getValues(uint start, uint count) public view returns (uint[] memory) {
        uint[] memory result = new uint[](count);
        for (uint i = 0; i < count; i++) {
            result[i] = values[start + i];
        }
        return result;
    }
}

// In this example, the getValues function returns an array of values stored
// in the values array, starting from a specified index and returning a 
// specified number of values. However, if the count parameter is set to a 
// very large value, the function may run out of gas and fail to complete, 
// causing a DoS attack. This vulnerability can be mitigated by limiting the 
// maximum value of the count parameter or by paginating the results to return 
// a limited number of values at a time.