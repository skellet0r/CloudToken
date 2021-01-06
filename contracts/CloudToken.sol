// SPDX-License-Identifier: MIT

pragma solidity ^0.7.5;

// Links to use when working on https://remix.ethereum.org/#optimize=true&runs=200&evmVersion=null&version=soljson-v0.7.5+commit.eb77ed08.js
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/SafeCast.sol";
// import "https://github.com/alphachainio/chainlink-contracts/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";


import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/SafeCast.sol";
import "@alphachain/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "./Token.sol";


/// @title A contract for interacting with the clouds
/// @author Edward Amor
contract CloudToken is Ownable, Token {
    using SafeMath for uint256;
    using SafeCast for int256;

    AggregatorV3Interface private priceFeed;

    /// @dev Amount '_supply' is the total supply of tokens in existence
    /// @dev '_feedAddress' is the address of a chainlink ETH/USD price feed oracle
    constructor(uint256 _supply, address _priceFeedAddress) public {
        priceFeed = AggregatorV3Interface(_priceFeedAddress);
        _mint(msg.sender, _supply);
    }

    /// @dev When the contract receives only ether, it'll create some new tokens for the sender
    receive() external payable {
        _mint(msg.sender, msg.value);
    }

    /// @dev There really isn't any reason we should get data and/or ether
    fallback() external {
        revert(); // dev: Fallback function called
    }

    /// @dev Withdraw ether from smart contract
    function withdraw(address _recipient, uint256 _amount)
        external
        onlyOwner
        returns (bool)
    {
        require(_amount <= address(this).balance); // dev: Insufficient ether balance
        address payable recipient = payable(_recipient);
        recipient.transfer(_amount);
        return true;
    }

    /// @dev Publicly accessible function to determine price of USD in wei
    function fetchUsdInWei() public view returns (uint256) {
        (, int256 price,,,) = priceFeed.latestRoundData();
        uint8 decimals = priceFeed.decimals();
        return usdToWei(price, decimals);
    }

    /**
        @dev When a user sends ether to the contract, we can use this function
        to determine the value of one usd in ether. Then we can peg our cloud token
        at exactly one usd or anyother value
        @param '_ethUsd' is the value of 1 ether in usd, this is a whole number
        which is derived by taking the float literal ethUSd conversion rate
        and multiplying by 10 ** decimals.
        @param '_decimals' the power of 10, which when multiplied with '_ethUsd'
        returns a whole number with no decimals

     */
    function usdToWei(int256 _ethUsd, uint8 _decimals) public pure returns (uint256) {
        uint256 ethUsd = _ethUsd.toUint256(); // using the SafeCast library for conversion
        uint256 numerator = 10 ** (18 + _decimals);
        return numerator.div(ethUsd);
    }

}
