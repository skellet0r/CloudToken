// SPDX-License-Identifier: MIT

pragma solidity ^0.7.5;

// import "https://github.com/alphachainio/chainlink-contracts/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@alphachain/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";


/**
    @title A mocked ETH/USD price feed chainlink oracle
    @dev Will always return a price of 1 ether = 100 USD
 */
contract PriceFeedOracle is AggregatorV3Interface {
    function decimals() external view override returns (uint8) {
        return 8;
    }

    function description() external view override returns (string memory) {
        return "This is a mock ETH/USD price oracle";
    }

    function version() external view override returns (uint256) {
        return 0;
    }

    function getRoundData(uint80 _roundId)
        external
        view
        override
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        return (0, 0, 0, 0, 0);
    }

    function latestRoundData()
        external
        view
        override
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        return (0, 10000000000, 0, 0, 0);
    }
}
