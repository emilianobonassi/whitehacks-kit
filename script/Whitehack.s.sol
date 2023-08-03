// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {Factory} from "../src/Factory.sol";
import {Whitehack} from "../src/Whitehack.sol";

contract WhitehackScript is Script {
    function run() public {
        vm.startBroadcast();
        console.log(msg.sender, "is running the script");

        // 0. Prepare the factory to deploy and execute in 1 go the whitehack
        // Can be removed if the factory is already deployed
        Factory factory = new Factory();
        console.log("factory deployed at:", address(factory));

        // 1. Prepare the whitehack parameters
        bytes memory params = abi.encode(
            uint256(42) // put here your params
        );
        // Advanced
        uint256 ethRequired = 0; // you should not need to send eth to the whitehack


        // 2. Deploy and execute the whitehack
        factory.deployAndExec{value: ethRequired}(
            ethRequired, 
            bytes32('whitehack'), 
            type(Whitehack).creationCode, 
            abi.encodeWithSignature("go(bytes)", params)
        );

        console.log("whitehack executed with success");

        vm.stopBroadcast();
    }
}