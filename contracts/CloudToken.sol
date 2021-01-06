// SPDX-License-Identifier: MIT

pragma solidity ^0.7.5;

// Links to use when working on https://remix.ethereum.org/#optimize=true&runs=200&evmVersion=null&version=soljson-v0.7.5+commit.eb77ed08.js
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Token.sol";


/// @title A contract for interacting with the clouds
/// @author Edward Amor
contract CloudToken is Ownable, Token {

    /// @dev Amount '_supply' is the total supply of tokens in existence
    /// @dev '_feedAddress' is the address of a chainlink ETH/USD price feed oracle
    constructor(uint256 _supply) public {
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

    /**
        @dev When a user sends ether to the contract, we can use this function
        to determine the value of one usd in ether. Then we can peg our cloud token
        at exactly one usd or anyother value
     */
    function usd_to_wei(uint256 _eth_usd, uint8 _decimals) public pure returns (uint256) {
        uint16 power = 18 + _decimals;
        return (10 ** power).div(_eth_usd);
    }

}
