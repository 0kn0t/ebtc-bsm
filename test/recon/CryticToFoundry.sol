// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";
import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";
import "forge-std/console2.sol";

// forge test --match-contract CryticToFoundry -vv
contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public override {
        setup();

        vm.label(address(mockAssetToken), "mockAssetToken");
        vm.label(address(mockEbtcToken), "mockEbtcToken");
        vm.label(address(second_actor), "second_actor");
        vm.label(address(this), "actor");
        vm.label(address(bsmTester), "bsmTester");
        vm.label(address(techOpsMultisig), "techOpsMultisig");
        vm.label(address(assetVault), "assetVault");
    }

    // forge test --match-test test_crytic -vvv
    function test_crytic() public {
        bsmTester_updateAssetVault();
    }

// forge test --match-test test_property_consistent_migrate_0 -vvv
function test_property_consistent_migrate_0() public {

    bsmTester_updateAssetVault();

    vm.roll(block.number + 19351);
    vm.warp(block.timestamp + 430051);
    inlined_withdrawProfitTest();

    externalVault_mint(0);

    switch_asset(125);

    vm.roll(block.number + 17332);
    vm.warp(block.timestamp + 260610);
    asset_mint(0xDB25A7b768311dE128BBDa7B8426c3f9C74f3240,973);

    property_accounting_is_sound();

    add_new_asset(90);

    inlined_withdrawProfitTest();

    vm.roll(block.number + 33650);
    vm.warp(block.timestamp + 119686);
    switch_asset(2378290172295313779714431852421723546935360004365715681661469911726663125017);

    vm.roll(block.number + 71);
    vm.warp(block.timestamp + 7411);
    property_accounting_is_sound();

    bsmTester_updateAssetVault();

    asset_approve(0x00000000000000000000000000000000DeaDBeef,2);

    vm.warp(block.timestamp + 261991);

    vm.roll(block.number + 22321);

    inlined_withdrawProfitTest();

    property_accounting_is_sound();

    asset_approve(0x00000000000000000000000000000000DeaDBeef,117598437708589298121948424085705718386);

    bsmTester_updateAssetVault();

    vm.roll(block.number + 26845);
    vm.warp(block.timestamp + 322338);
    bsmTester_updateAssetVault();

    vm.roll(block.number + 12);
    vm.warp(block.timestamp + 322342);
    property_consistent_migrate();

 }

    // forge test --match-test test_property_fees_profit_increases_0 -vvv
function test_property_fees_profit_increases_0() public {

    vm.warp(block.timestamp + 62499);

    vm.roll(block.number + 56947);

    vm.roll(block.number + 13492);
    vm.warp(block.timestamp + 193645);
    switch_asset(36042788069725765836074178354548498787165516727960402931017674180166925710953);

    inlined_withdrawProfitTest();

    vm.warp(block.timestamp + 430057);

    vm.roll(block.number + 36280);

    vm.roll(block.number + 19);
    vm.warp(block.timestamp + 353525);
    asset_mint(0x03A6a84cD762D9707A21605b548aaaB891562aAb,12466209331830927527120773382362615109);

    bsmTester_pause();

    vm.roll(block.number + 51184);
    vm.warp(block.timestamp + 33854);
    property_accounting_is_sound();

    vm.roll(block.number + 4960);
    vm.warp(block.timestamp + 128729);
    asset_mint(0x00000000000000000000000000000001fffffffE,13283836693685032288371342404844447680);

    bsmTester_unpause();

    vm.warp(block.timestamp + 289607);

    vm.roll(block.number + 18055);

    vm.roll(block.number + 38794);
    vm.warp(block.timestamp + 13169);
    bsmTester_pause();

    switch_asset(115792089237316195423570985008687907853269984665640564039447584007913129639935);

    switchActor(115792089237316195423570985008687907853269984665640564039448594007913129639935);

    vm.roll(block.number + 28272);
    vm.warp(block.timestamp + 555652);
    property_fees_profit_increases();

    vm.warp(block.timestamp + 504743);

    vm.roll(block.number + 127352);

    vm.roll(block.number + 1426);
    vm.warp(block.timestamp + 449931);
    bsmTester_setFeeToBuyAsset(74);

    asset_mint(0x00000000000000000000000000000002fFffFffD,542);

    asset_mint(0xD16d567549A2a2a2005aEACf7fB193851603dd70,139325);

    switch_asset(0);

    vm.warp(block.timestamp + 2317982);

    vm.roll(block.number + 101474);

    vm.roll(block.number + 48578);
    vm.warp(block.timestamp + 555654);
    asset_approve(0x00000000000000000000000000000000DeaDBeef,755132739974436551);

    vm.warp(block.timestamp + 1202202);

    vm.roll(block.number + 69748);

    add_new_asset(3);

    vm.roll(block.number + 4995);
    vm.warp(block.timestamp + 2001);
    add_new_asset(0);

    assetVault_claimProfit();

    vm.roll(block.number + 14320);
    vm.warp(block.timestamp + 569114);
    property_fees_profit_increases();

    vm.roll(block.number + 100);
    vm.warp(block.timestamp + 555652);
    switch_asset(48011788450157849936488545747325775012288340122737972524570495842389504513703);

    bsmTester_updateAssetVault();

    vm.warp(block.timestamp + 202687);

    vm.roll(block.number + 6299);

    vm.roll(block.number + 58093);
    vm.warp(block.timestamp + 469818);
    assetVault_claimProfit();

    vm.warp(block.timestamp + 225906);

    vm.roll(block.number + 30241);

    vm.roll(block.number + 48444);
    vm.warp(block.timestamp + 569114);
    bsmTester_updateAssetVault();

    vm.warp(block.timestamp + 754703);

    vm.roll(block.number + 107780);

    vm.roll(block.number + 2497);
    vm.warp(block.timestamp + 322339);
    property_fees_profit_increases();

 }

// forge test --match-test test_doomsday_bsmTester_updateAssetVault_always_works_0 -vvv 
    function test_doomsday_bsmTester_updateAssetVault_always_works_0() public {

        bsmTester_buyEbtcWithAsset(3);

        switch_asset(1);

        asset_mint(0xc7183455a4C133Ae270771860664b6B7ec320bB1, 1);

        console2.log("assetVault.totalBalance()", assetVault.totalBalance());
        console2.log("assetVault.depositAmount()", assetVault.depositAmount());

        assetVault_depositToExternalVault_rekt(3, 0);

        doomsday_bsmTester_updateAssetVault_always_works();

    }

    // forge test --match-test test_property_accounting_is_sound_0 -vvv
    function test_property_accounting_is_sound_0() public {

        bsmTester_buyEbtcWithAsset(1);

        switch_asset(1);

        asset_mint(0xc7183455a4C133Ae270771860664b6B7ec320bB1, 1);

        assetVault_depositToExternalVault_rekt(1, 0);

        property_accounting_is_sound();

    }

// forge test --match-test test_inlined_withdrawProfitTest_1 -vvv 
    function test_inlined_withdrawProfitTest_1() public {

        bsmTester_buyEbtcWithAsset(1);

        assetVault_depositToExternalVault_rekt(1, 0);

        bsmTester_updateAssetVault();

        inlined_withdrawProfitTest();

    }
}
