pragma solidity 0.7.0;

import "forge-std/Script.sol";
import {InSecureumToken} from "src/race_01/InSecureumToken.sol";

contract Deployment is Script {
    // Deploy to Anvil with:
    // forge script script/InSecureumToken.s.sol:Deployment --fork-url http://localhost:8545 --broadcast
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("ANVIL_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        new InSecureumToken();
        (bool success,) = address(0x30000).call{value: 500 ether}("");
        require(success, "Failed to send ether to 0x30000");
        vm.stopBroadcast();
    }
}
