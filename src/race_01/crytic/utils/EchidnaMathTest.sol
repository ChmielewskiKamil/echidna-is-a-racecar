pragma solidity 0.7.0;

import {InSecureumToken} from "src/race_01/InSecureumToken.sol";

contract EchidnaMathTest is InSecureumToken {
  // (x + y) + z == x + (y + z)
  function test_add_associative(uint256 x, uint256 y, uint256 z) public pure {
    uint256 x_y = safeAdd(x, y);
    uint256 y_z = safeAdd(y, z);
    uint256 xy_z = safeAdd(x_y, z);
    uint256 x_yz = safeAdd(x, y_z);
    assert(xy_z == x_yz);
  } 
}
