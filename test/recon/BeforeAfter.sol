// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Setup} from "./Setup.sol";

    enum OpType {
        GENERIC,
        MIGRATE,
        CLAIM // This op resets the fee
    }

// ghost variables for tracking state variable values before and after function calls
abstract contract BeforeAfter is Setup {
    struct Vars {
        uint256 feesProfit;
        uint256 depositAmount;
    }

    Vars internal _before;
    Vars internal _after;
    OpType internal currentOperation;

    modifier updateGhosts() {
        currentOperation = OpType.GENERIC;
        __before();
        _;
        __after();
    }

    modifier updateGhostsWithType(OpType op) {
        currentOperation = op;
        __before();
        _;
        __after();
    }

    function __before() internal {
        _before.feesProfit = assetVault.feeProfit();
        _before.depositAmount = assetVault.depositAmount();
    }

    function __after() internal {
        _after.feesProfit = assetVault.feeProfit();
        _after.depositAmount = assetVault.depositAmount();
    }
}
