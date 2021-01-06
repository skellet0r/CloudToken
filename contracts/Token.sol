// SPDX-License-Identifier: MIT

pragma solidity ^0.7.5;

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";


/// @title ERC-20 spec coded out into a contract
/// @author Edward Amor
/// @dev To be inherited from, encapsulating all of the ERC20 functionality
contract Token {
    using SafeMath for uint256;

    uint256 internal _totalSupply; // Total number of tokens in existence
    mapping(address => uint256) internal _balances; // Token holder balances
    mapping(address => mapping(address => uint256)) internal _allowances; // Map of allowances

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    /// @dev Approve the spending of '_amount' of sender tokens by spender
    function approve(address _spender, uint256 _amount)
        external
        returns (bool)
    {
        _allowances[msg.sender][_spender] = _amount; // Set the balance, overwritting the previous allowance
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    /**
        @dev Transfer '_amount' of tokens to '_recipient' from sender.
        This is a wrapper around the _transfer function.
     */
    function transfer(address _recipient, uint256 _amount)
        external
        _verify_balance(msg.sender, _amount)
        returns (bool)
    {
        _transfer(msg.sender, _recipient, _amount);
        return true;
    }

    /// @dev Tranfer tokens from '_owner' to '_recipient' and decrement sender's allowance
    function transferFrom(address _sender, address _recipient, uint256 _amount)
        external
        _verify_allowance(_sender, msg.sender, _amount)
        _verify_balance(_sender, _amount)
        returns (bool)
    {
        _allowances[_sender][msg.sender] = _allowances[_sender][msg.sender].sub(
            _amount
        );
        _transfer(_sender, _recipient, _amount);
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

    /// @dev Return the balance of a token holder
    function balanceOf(address _account) external view returns (uint256) {
        return _balances[_account];
    }

    /// @dev Return the total supply of tokens in existence
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    /// @dev Allows for the creation of new tokens, which are given to '_account'
    function _mint(address _account, uint256 _amount) internal {
        _balances[_account] = _balances[_account].add(_amount);
        _totalSupply = _totalSupply.add(_amount);
    }

    /// @dev Private function which implements the core transfer logic
    function _transfer(address _sender, address _recipient, uint256 _amount)
        private
    {
        _balances[_sender] = _balances[_sender].sub(_amount);
        _balances[_recipient] = _balances[_recipient].add(_amount);
        emit Transfer(_sender, _recipient, _amount);
    }

    /**
        @dev Modifier to verify that '_account' has a balance of '_amount'
        or greater
     */
    modifier _verify_balance(address _account, uint256 _amount) {
        require(_balances[_account] >= _amount); // dev: Insufficient balance
        _;
    }

    /**
        @dev Modifier to verify that '_spender' has a sufficient balance
        to spend '_owner's tokens
     */
    modifier _verify_allowance(
        address _owner,
        address _spender,
        uint256 _amount
    ) {
        require(_allowances[_owner][_spender] >= _amount); // dev: Insufficient allowance
        _;
    }
}
