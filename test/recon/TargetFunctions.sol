// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Targets
// NOTE: Always import and apply them in alphabetical order, so much easier to debug!
import {AdminTargets} from "./targets/AdminTargets.sol";
import {InlinedTests} from "./targets/InlinedTests.sol";
import {ManagersTargets} from "./targets/ManagersTargets.sol";

abstract contract TargetFunctions is AdminTargets, InlinedTests, ManagersTargets {
    function bsmTester_buyAssetWithEbtc(uint256 _ebtcAmountIn) public updateGhosts asActor {
        bsmTester.buyAssetWithEbtc(_ebtcAmountIn);
    }

    function bsmTester_buyEbtcWithAsset(uint256 _assetAmountIn) public updateGhosts asActor {
        bsmTester.buyEbtcWithAsset(_assetAmountIn);
    }

    // Donations directly to the underlying vault
    function externalVault_mint(uint256 _amount) public updateGhosts asActor {
        externalVault.deposit(_amount, _getActor());
    }

    function externalVault_withdraw(uint256 _amount) public updateGhosts asActor{
        externalVault.withdraw(_amount, _getActor(), _getActor());
    }
}
