// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {OpType, BeforeAfter} from "./BeforeAfter.sol";

abstract contract Properties is BeforeAfter, Asserts {
    function property_accounting_is_sound() public {
        gte(assetVault.totalBalance(), assetVault.depositAmount(), "accounting is sound");
    }

    function property_fees_profit_increases() public {
        if (currentOperation == OpType.CLAIM) {
            // claims are all total, there are no partial claims
            eq(assetVault.feeProfit(), 0, "Profit should be 0");
        } else if (currentOperation == OpType.MIGRATE) {

        } else {
            // any other operation should increase the profit or stay the same
            gte(_after.feesProfit, _before.feesProfit, "Profit should only increase");
        }
    }

    function property_consistent_migrate() public {
        if (currentOperation == OpType.MIGRATE) {
            eq(_after.depositAmount, _before.depositAmount, "Deposit amount should be consistent after migrate");
        }
    }
}
