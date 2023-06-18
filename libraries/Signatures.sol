// contracts/libraries/Signature.sol
// SPDX-License-Identifier: MIT
pragma solidity = 0.8.8;
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

library Signatures 
{
    function _recoverAddress(
        bytes memory proposal,
        bytes memory signature
    )
    internal pure returns (address)
    {
        bytes32 h = ECDSA.toEthSignedMessageHash(keccak256(proposal));
        return ECDSA.recover(h,signature);
    }

    function _unpackSignature(bytes memory signatures, uint8 sigIndex)
    internal pure returns(bytes memory sig)
    {
        assembly {
            let sigLocation := 
                add(
                    signatures,
                    mul(sigIndex,65))
            let mem := mload(0x40)
            mstore(0x40,add(mem,0x80))
            mstore(add(mem,0x00),65)
            mstore(add(mem,0x20),mload(add(sigLocation,0x20)))
            mstore(add(mem,0x40),mload(add(sigLocation,0x40)))
            mstore(add(mem,0x60),mload(add(sigLocation,0x60)))
            sig:=mem
        }
    }

    function _getSignaturesCount(bytes memory packedSig)
    internal pure returns(uint8)
    {
        uint8 sigCount;
        sigCount = uint8(packedSig.length) / 65;
        require(uint8(packedSig.length) % 65 == 0, "Governance: Invalid signature array length");
        return sigCount;
    }

    function _hasSigned(address[] memory signedList, address signatory) 
    internal pure returns (bool) {
        uint256 length = signedList.length;
        for (uint256 i = 0; i < length; i++) {
            if (signedList[i] == signatory)
                return true;
        }
        return false;
    }

}