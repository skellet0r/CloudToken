// SPDX-License-Identifier: MIT

pragma solidity ^0.7.5;

import "@openzeppelin/contracts/math/SafeMath.sol";


/// @title A contract for interacting with the clouds
/// @author Edward Amor
contract CloudToken {
    using SafeMath for uint256;

    event Transfer(address indexed from, address indexed to, uint256 value);

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;

    /// @dev Amount '_supply' is the total supply of tokens in existence
    constructor(uint256 _supply) public {
        _totalSupply = _supply;
        _balances[msg.sender] = _supply;
    }

    /// @dev Return the total supply of tokens in existence
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    /// @dev Return the balance of a token holder
    function balanceOf(address _account) external view returns (uint256) {
        return _balances[_account];
    }

    /// @dev Transfer '_amount' of tokens to '_recipient' from sender
    function transfer(address _recipient, uint256 _amount)
        external
        returns (bool)
    {
        require(_balances[msg.sender] >= _amount); // dev: Insufficient balance
        _balances[msg.sender] = _balances[msg.sender].sub(_amount);
        _balances[_recipient] = _balances[_recipient].add(_amount);
        emit Transfer(_recipient, msg.sender, _amount);
        return true;
    }
}
