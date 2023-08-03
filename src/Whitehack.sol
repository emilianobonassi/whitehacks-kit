// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Whitehack {

    constructor() payable {}

    function go(bytes calldata params) external returns (bytes memory) {
        // decode and use params
        // uint256 param1 = abi.decode(params, (uint256));

        return params;
    }

    fallback() external {}
}