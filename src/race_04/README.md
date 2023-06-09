
### Slither ERC conformance check

```shell
slither-check-erc src/race_04/InSecureum.sol InSecureum --solc-remaps openzeppelin-contracts/=lib/openzeppelin-contracts/
```

# Check InSecureum

## Check functions

[✓] totalSupply() is present

[✓] totalSupply() -> (uint256) (correct return type)

[✓] totalSupply() is view

[✓] balanceOf(address) is present

[✓] balanceOf(address) -> (uint256) (correct return type)

[✓] balanceOf(address) is view

[✓] transfer(address,uint256) is present

[✓] transfer(address,uint256) -> (bool) (correct return type)

[✓] Transfer(address,address,uint256) is emitted

[✓] transferFrom(address,address,uint256) is present

[✓] transferFrom(address,address,uint256) -> (bool) (correct return type)

[✓] Transfer(address,address,uint256) is emitted

[✓] approve(address,uint256) is present

[✓] approve(address,uint256) -> (bool) (correct return type)

[✓] Approval(address,address,uint256) is emitted

[✓] allowance(address,address) is present

[✓] allowance(address,address) -> (uint256) (correct return type)

[✓] allowance(address,address) is view

[✓] name() is present

[✓] name() -> (string) (correct return type)

[✓] name() is view

[✓] symbol() is present

[✓] symbol() -> (string) (correct return type)

[✓] symbol() is view

[✓] decimals() is present

[✓] decimals() -> (uint8) (correct return type)

[✓] decimals() is view

## Check events

[✓] Transfer(address,address,uint256) is present

[✓] parameter 0 is indexed
[✓] parameter 1 is indexed

[✓] Approval(address,address,uint256) is present

[✓] parameter 0 is indexed
[✓] parameter 1 is indexed

[✓] InSecureum has increaseAllowance(address,uint256)
