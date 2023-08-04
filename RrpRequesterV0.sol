// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@api3/airnode-protocol/contracts/rrp/interfaces/IAirnodeRrpV0.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @title The contract to be inherited to make Airnode RRP requests
contract RrpRequesterV0 is Initializable {
    IAirnodeRrpV0 public airnodeRrp;

    /// @dev Reverts if the caller is not the Airnode RRP contract.
    /// Use it as a modifier for fulfill and error callback methods, but also
    /// check `requestId`.
    modifier onlyAirnodeRrp() {
        require(msg.sender == address(airnodeRrp), "Caller not Airnode RRP");
        _;
    }

    /// @dev Airnode RRP address is set at deployment and is immutable.
    /// RrpRequester is made its own sponsor by default. RrpRequester can also
    /// be sponsored by others and use these sponsorships while making
    /// requests, i.e., using this default sponsorship is optional.
    /// @param _airnodeRrp Airnode RRP contract address
    // constructor(address _airnodeRrp) {
    //     airnodeRrp = IAirnodeRrpV0(_airnodeRrp);
    //     IAirnodeRrpV0(_airnodeRrp).setSponsorshipStatus(address(this), true);
    // }

    function __RrpRequesterV0_init(address _airnodeRrp) internal onlyInitializing {
        __RrpRequesterV0_init_unchained(_airnodeRrp);
    }

    function __RrpRequesterV0_init_unchained(address _airnodeRrp) internal onlyInitializing {
        airnodeRrp = IAirnodeRrpV0(_airnodeRrp);
        IAirnodeRrpV0(_airnodeRrp).setSponsorshipStatus(address(this), true);
    }

    uint256[50] private __gap;
}
