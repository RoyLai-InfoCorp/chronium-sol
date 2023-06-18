// contracts/libraries/Concat.sol
// SPDX-License-Identifier: MIT
pragma solidity = 0.8.8;
import "@openzeppelin/contracts/utils/Strings.sol";

/** 
*    String concatenation
*/
library Concat {

    function concat(string memory message, string memory content) 
    internal pure returns(string memory)
    {
        return string(abi.encodePacked(message,content," "));
    }

    function concat(string memory message, uint256 number) 
    internal pure returns(string memory)
    {
        return concat(message,Strings.toString(number));
    }

    function concat(string memory message, address content) 
    internal pure returns(string memory)
    {
        return concat(message,Strings.toHexString(uint160(content), 20));
    }

}