pragma solidity 0.8.0;

import {InSecureumNFT} from "../InSecureumNFT.sol";

contract BasicDeployment {
  InSecureumNFT nftContract = InSecureumNFT(0x5b73C5498c1E3b4dbA84de0F1833c4a029d90519);
  address deployer = 0x90F79bf6EB2c4f870365E785982E1f101E93b906;
  address beneficiary = 0x5c4d2bd3510C8B51eDB17766d3c96EC637326999;
}
