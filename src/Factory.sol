// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Create2} from "@openzeppelin/contracts/utils/Create2.sol";

contract Factory {
    function deployAndExec(
        uint256 amount,
        bytes32 salt,
        bytes calldata initcode,
        bytes calldata data
    ) public payable returns (address, bytes memory) {
        address addr = Create2.deploy(amount, salt, initcode);

        (bool success, bytes memory ret) = addr.call(data);
        
        require(success, "execution failed");

        return (addr, ret);
    }
}
