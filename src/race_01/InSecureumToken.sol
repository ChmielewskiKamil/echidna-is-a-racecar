pragma solidity 0.7.0;

contract InSecureumToken {
    // @audit-info - private -> public for testing purposes
    mapping(address => uint256) public balances;

    uint256 public decimals = 10 ** 18; // decimals of the token
    uint256 public totalSupply; // total supply
    // @audit-issue - MAX_SUPPLY is never used
    uint256 MAX_SUPPLY = 100 ether; // Maximum total supply

    event Mint(address indexed destination, uint256 amount);

    // @audit - transfer does not check for address(0)
    function transfer(address to, uint256 amount) public {
        // save the balance in local variables
        // so that we can re-use them multiple times
        // without paying for SLOAD on every access
        uint256 balance_from = balances[msg.sender];
        uint256 balance_to = balances[to];
        require(balance_from >= amount);
        balances[msg.sender] = balance_from - amount;
        balances[to] = safeAdd(balance_to, amount);
    }

    // @invariant - When msg.value is 0, user's token balance should not increase
    /// @notice Allow users to buy token. 1 ether = 10 tokens
    /// @dev Users can send more ether than token to be bought, to donate a fee to the protocol team.
    function buy(uint256 desired_tokens) public payable {
        // Check if enough ether has been sent
        // @audit-issue - If desired_tokens < 10, then required_wei_sent will
        // be rounded down to 0
        // multiply before dividing
        uint256 required_wei_sent = (desired_tokens / 10) * decimals;
        require(msg.value >= required_wei_sent);

        // Mint the tokens
        totalSupply = safeAdd(totalSupply, desired_tokens);
        balances[msg.sender] = safeAdd(balances[msg.sender], desired_tokens);
        emit Mint(msg.sender, desired_tokens);
    }

    // @audit - Math functions are difficult to test without duplicating
    // function's logic
    // A good way to test such functions is to test the mathematical properties that
    // arise from them, e.g. add(a, b) = c, then sub(c, b) = a, sub(c, a) = b
    /// @notice Add two values. Revert if overflow
    function safeAdd(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a + b < a) {
            revert();
        }
        return a + b;
    }
}
