// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {AuthNoOwner} from "./Dependencies/AuthNoOwner.sol";
import {IOracleModule} from "./Dependencies/IOracleModule.sol";
import {AggregatorV3Interface} from "./Dependencies/AggregatorV3Interface.sol";

contract OracleModule is IOracleModule, AuthNoOwner {
    uint256 public constant BPS = 10000;

    /// @notice Asset feed is denominated in BTC (i.e. tBTC/BTC)
    AggregatorV3Interface public immutable ASSET_FEED;
    uint256 public immutable ASSET_FEED_PRECISION;

    uint256 public minPriceBPS;
    uint256 public oracleFreshnessSeconds;

    event MinPriceUpdated(uint256 oldMinPrice, uint256 newMinPrice);
    event OracleFreshnessUpdated(
        uint256 oldOracleFreshness,
        uint256 newOracleFreshness
    );

    error BadOraclePrice(int256 price);
    error StaleOraclePrice(uint256 updatedAt);

    constructor(address _assetFeed, address _governance) {
        ASSET_FEED = AggregatorV3Interface(_assetFeed);
        ASSET_FEED_PRECISION = 10 ** ASSET_FEED.decimals();
        _initializeAuthority(_governance);
        minPriceBPS = BPS;
        oracleFreshnessSeconds = 1 days;
    }

    function _getAssetPrice() private view returns (uint256) {
        (, int256 answer, , uint256 updatedAt, ) = ASSET_FEED.latestRoundData();

        if (answer <= 0) revert BadOraclePrice(answer);

        if ((block.timestamp - updatedAt) > oracleFreshnessSeconds) {
            revert StaleOraclePrice(updatedAt);
        }

        return (uint256(answer) * 1e18) / ASSET_FEED_PRECISION;
    }

    function canMint() external returns (bool) {
        uint256 assetPrice = _getAssetPrice();
        /// @dev peg price is 1e18
        uint256 minAcceptablePrice = 1e18 * minPriceBPS / BPS;

        return minAcceptablePrice <= assetPrice;
    }

    function setMinPrice(uint256 _minPriceBPS) external requiresAuth {
        require(_minPriceBPS <= BPS);
        emit MinPriceUpdated(minPriceBPS, _minPriceBPS);
        minPriceBPS = _minPriceBPS;
    }

    function setOracleFreshness(
        uint256 _oracleFreshnessSeconds
    ) external requiresAuth {
        emit OracleFreshnessUpdated(
            oracleFreshnessSeconds,
            _oracleFreshnessSeconds
        );
        oracleFreshnessSeconds = _oracleFreshnessSeconds;
    }
}
