pragma solidity 0.7.0;

/// @dev The Addresses.sol file contains a list of contract addresses
/// deployed to anvil with the deployment script.
/// Thanks to this approach we do not have to deploy anything
/// in the EchidnaTest contract (or EchidnaSetup contract).
/// Addresses.sol also imports all of the necessary project contracts.
/// That's why we don't have to explicitly import them here.
import {Addresses} from "./utils/Addresses.sol";

/// @dev Run Echidna tests with:
/// echidna src/race_01/crytic/EchidnaTest.sol --contract EchidnaTest --config src/race_01/crytic/echidna_config.yaml
/// @notice Look at the .env file. You need to set the Echidna RPC settings,
/// for the fork mode to work. Also make sure that you have Anvil running,
/// with all the contracts deployed with `forge script`.
contract EchidnaTest is Addresses {

    function token_should_be_deployed() public view {
        assert(address(token) == address(0x057ef64E23666F000b34aE31332854aCBd1c8544));
    }

    function total_supply_should_be_le_max_supply() public view {
        uint256 totalSupply = token.totalSupply();
        uint256 maxSupply = 100 ether;
        assert(totalSupply <= maxSupply);
    }
}
