pragma solidity 0.7.0;

/// @dev The Addresses.sol file contains a list of contract addresses
/// deployed to anvil with the deployment script.
/// Thanks to this approach we do not have to deploy anything
/// in the EchidnaTest contract (or EchidnaSetup contract).
/// Addresses.sol also imports all of the necessary project contracts.
/// That's why we don't have to explicitly import them here.
import {Addresses} from "./utils/Addresses.sol";
import {PropertiesAsserts} from "./utils/PropertiesHelper.sol";

/// @dev Run Echidna tests with:
/// echidna src/race_01/crytic/EchidnaTest.sol --contract EchidnaTest --config src/race_01/crytic/echidna_config.yaml
/// @notice Look at the .env file. You need to set the Echidna RPC settings,
/// for the fork mode to work. Also make sure that you have Anvil running,
/// with all the contracts deployed with `forge script`.
contract EchidnaTest is Addresses, PropertiesAsserts {

    event SenderBalance(uint256 balance);

    function total_supply_should_be_lte_max_supply() public {
        uint256 totalSupply = token.totalSupply();
        uint256 maxSupply = 100 ether;
        assertLte(totalSupply, maxSupply, "Total supply is greater than max supply.");
    }

    function buying_tokens_for_free_should_not_be_possible(uint256 desired_tokens) public payable {
        // preconditions
        require(msg.value == 0);
        uint256 senderEtherBalanceBefore = msg.sender.balance;
        uint256 senderTokenBalanceBefore = token.balances(msg.sender);

        // action
        token.buy(desired_tokens);

        // postconditions
        uint256 senderEtherBalanceAfter = msg.sender.balance;
        uint256 senderTokenBalanceAfter = token.balances(msg.sender);
        assertEq(senderEtherBalanceBefore, senderEtherBalanceAfter, "Ether balance should not change.");
        assertEq(senderTokenBalanceBefore, senderTokenBalanceAfter, "Token balance should not change.");
    }

    function buying_tokens_should_increase_balance(uint256 desired_tokens) public payable {
        // preconditions
        uint256 senderEtherBalanceBefore = msg.sender.balance;
        uint256 senderTokenBalanceBefore = token.balances(msg.sender);
        uint256 ether_sent = msg.value;
        emit SenderBalance(senderEtherBalanceBefore);

        // action
        try token.buy{value: ether_sent}(desired_tokens) {
            // token.buy is successful
            // postconditions
            require(desired_tokens > 0 && ether_sent > 0);
            uint256 senderEtherBalanceAfter = msg.sender.balance;
            uint256 senderTokenBalanceAfter = token.balances(msg.sender);
            assertEq(senderEtherBalanceBefore - ether_sent, senderEtherBalanceAfter, "Ether balance should decrease.");
            assertEq(
                senderTokenBalanceBefore + desired_tokens, senderTokenBalanceAfter, "Token balance should increase."
            );
        } catch {
            // token.buy failed
            // postconditions
            uint256 senderEtherBalanceAfter = msg.sender.balance;
            uint256 senderTokenBalanceAfter = token.balances(msg.sender);
            assertEq(senderEtherBalanceBefore, senderEtherBalanceAfter, "Ether balance should not change.");
            assertEq(senderTokenBalanceBefore, senderTokenBalanceAfter, "Token balance should not change.");
        }
    }
}
