pragma solidity 0.7.0;

/// @dev The Addresses.sol file contains a list of contract addresses
/// deployed to anvil with the deployment script.
/// Thanks to this approach we do not have to deploy anything 
/// in the EchidnaTest contract (or EchidnaSetup contract).
import {Addresses} from "./utils/Addresses.sol";

contract EchidnaTest is Addresses {
  function token_should_be_deployed() public view {
    assert(address(token) != address(0));
  }
}

