// SPDX-License-Identifier: MIT

pragma solidity ^0.7.5;

// Links to use when working on https://remix.ethereum.org/#optimize=true&runs=200&evmVersion=null&version=soljson-v0.7.5+commit.eb77ed08.js
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";
// import "https://github.com/alphachainio/chainlink-contracts/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


/// @title A contract for interacting with the clouds
/// @author Edward Amor
contract CloudToken is Ownable {
    using SafeMath for uint256;

    receive() external payable {
        _mint(msg.sender, msg.value);
    }

    fallback() external {
        revert(); // dev: Fallback function called
    }

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

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    uint256 private _totalSupply; // Total number of tokens in existence
    mapping(address => uint256) private _balances; // Token holder balances
    mapping(address => mapping(address => uint256)) private _allowances; // Map of allowances

    /// @dev Amount '_supply' is the total supply of tokens in existence
    /// @dev '_feedAddress' is the address of a chainlink ETH/USD price feed oracle
    constructor(uint256 _supply) public {
        _mint(msg.sender, _supply);
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

    /// @dev Allows for the creation of new tokens, which are given to '_account'
    function _mint(address _account, uint256 _amount) private {
        _balances[_account] = _balances[_account].add(_amount);
        _totalSupply = _totalSupply.add(_amount);
    }

    /// @dev Return the total supply of tokens in existence
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    /// @dev Return the balance of a token holder
    function balanceOf(address _account) external view returns (uint256) {
        return _balances[_account];
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
        _allowances[msg.sender][_spender] = _amount; // Set the balance, overwritting the previous allowance
        emit Approval(msg.sender, _spender, _amount);
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

    /**
        @dev Modifier to verify that '_account' has a balance of '_amount'
        or greater
     */
    modifier _verify_balance(address _account, uint256 _amount) {
        require(_balances[_account] >= _amount); // dev: Insufficient balance
        _;
    }

    modifier _verify_allowance(
        address _owner,
        address _spender,
        uint256 _amount
    ) {
        require(_allowances[_owner][_spender] >= _amount); // dev: Insufficient allowance
        _;
    }

    /// @dev Private function which implements the core transfer logic
    function _transfer(address _sender, address _recipient, uint256 _amount)
        private
    {
        _balances[_sender] = _balances[_sender].sub(_amount);
        _balances[_recipient] = _balances[_recipient].add(_amount);
        emit Transfer(_sender, _recipient, _amount);
    }
}
