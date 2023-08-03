// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Factory} from "../src/Factory.sol";
import {Whitehack} from "../src/Whitehack.sol";

import {Create2} from "@openzeppelin/contracts/utils/Create2.sol";

contract FactoryTest is Test {
    Factory public factory;

    function setUp() public {
        factory = new Factory();
    }

    function testDeployAndExecNoEth() public {
        bytes memory initcode = type(Whitehack).creationCode;

        bytes memory params = abi.encode(uint256(42));
        bytes memory data = abi.encodeWithSignature("go(bytes)", params);
        bytes32 salt = bytes32('salt');

        address expectedAddr = Create2.computeAddress(bytes32('salt'), keccak256(initcode), address(factory));

        (address addr, bytes memory ret) = factory.deployAndExec{value: 0}(0, salt, initcode, data);
        
        assertEq(addr, expectedAddr);
        assertEq(abi.decode(ret, (bytes)), params);
    }

    function testDeployAndExecEth() public {
        bytes memory initcode = type(Whitehack).creationCode;

        bytes memory params = abi.encode(uint256(42));
        bytes memory data = abi.encodeWithSignature("go(bytes)", params);
        bytes32 salt = bytes32('salt');
        uint256 ethBalance = 123;

        address expectedAddr = Create2.computeAddress(bytes32('salt'), keccak256(initcode), address(factory));

        (address addr, bytes memory ret) = factory.deployAndExec{value: ethBalance}(ethBalance, salt, initcode, data);
        
        assertEq(addr, expectedAddr);
        assertEq(abi.decode(ret, (bytes)), params);
        assertEq(addr.balance, ethBalance);
    }
}
