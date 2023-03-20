pragma solidity 0.8.0;

import "forge-std/Script.sol";
import {InSecureumNFT} from "src/race_03/InSecureumNFT.sol";

contract Deployment is Script {
    // Deploy to Anvil with:
    // forge script script/InSecureumNFT.s.sol:Deployment --fork-url http://localhost:8545 --broadcast
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("ANVIL_PRIVATE_KEY");
        address deployer = vm.envAddress("ANVIL_DEPLOYER_ADDRESS");
        address beneficiary = makeAddr("beneficiary");
        vm.startBroadcast(deployerPrivateKey);
        new InSecureumNFT(payable(beneficiary));
        console.log("Deployed InSecureumNFT to", address(this));
        console.log("Deployer", deployer);
        console.log("Beneficiary", beneficiary);
        vm.stopBroadcast();
    }
}
