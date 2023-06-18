// contracts/libraries/Concat.sol
// SPDX-License-Identifier: MIT
pragma solidity = 0.8.8;
import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetFixedSupply.sol";

contract Erc20Token is ERC20PresetFixedSupply {
    constructor (string memory name, string memory symbol, uint initialSupply, address owner)
    ERC20PresetFixedSupply(name, symbol, initialSupply, owner)
    {
    }
}

contract Erc20Factory {

    event TokenDeployed(address tokenAddress);

    function deployNewToken(string calldata name, string calldata symbol, uint totalSupply, address issuer) 
    external returns (address newAddress, IERC20 erc) {
        Erc20Token t = new Erc20Token(name, symbol, totalSupply, issuer);
        newAddress = address(t);
        erc=IERC20(erc);
        emit TokenDeployed(newAddress);
    }
}