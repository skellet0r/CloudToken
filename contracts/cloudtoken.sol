// SPDX-License-Identifier: MIT

pragma solidity ^0.7.5;

import "@openzeppelin/contracts/math/SafeMath.sol";


/// @title A contract for interacting with the clouds
/// @author Edward Amor
contract CloudToken {
    using SafeMath for uint256;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

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
        _verify_balance(msg.sender, _amount)
        returns (bool)
    {
        _balances[msg.sender] = _balances[msg.sender].sub(_amount);
        _balances[_recipient] = _balances[_recipient].add(_amount);
        emit Transfer(_recipient, msg.sender, _amount);
        return true;
    }

    /// @dev Check the remaining number of tokens '_spender' is allowed to spend on '_owner' behalf
    function allowance(address _owner, address _spender)
        external
        view
        returns (uint256)
    {
        return _allowances[_owner][_spender];
    }

    /// @dev Approve the spending of '_amount' of sender tokens by spender
    function approve(address _spender, uint256 _amount)
        external
        returns (bool)
    {
        _allowances[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    /// @dev Tranfer tokens from '_owner' to '_recipient' and decrement sender's allowance
    function transferFrom(address _sender, address _recipient, uint256 _amount)
        external
        _verify_balance(_sender, _amount)
        returns (bool)
    {
        require(_allowances[_sender][msg.sender] >= _amount); // dev: Insufficient allowance
        _allowances[_sender][msg.sender] = _allowances[_sender][msg.sender].sub(
            _amount
        );
        _balances[_sender] = _balances[_sender].sub(_amount);
        _balances[_recipient] = _balances[_recipient].add(_amount);
        emit Transfer(_sender, _recipient, _amount);
        return true;
    }

    /**
        @dev Modifier to verify that '_account' has a balance of '_amount'
        or greater
     */
    modifier _verify_balance(address _account, uint256 _amount) {
        require(_balances[_account] >= _amount); // dev: Insufficient balance
        _;
    }
}
