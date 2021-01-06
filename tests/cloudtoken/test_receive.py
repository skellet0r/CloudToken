"""Conversion rates with Mocked Price Feed reference
1     ETH = 10 ** 18 wei = 100 USD = 10000 XCT
.01   ETH = 10 ** 16 wei =   1 USD =   100 XCT
.0001 ETH = 10 ** 14 wei = .01 USD =     1 XCT

XCT = CloudToken
"""


def test_receive_increases_balance_of_sender(beth, token, web3):
    initial_balance = token.balanceOf(beth)
    beth.transfer(token, web3.toWei(0.01, "ether"))

    assert token.balanceOf(beth) == initial_balance + 100


def test_receive_increases_total_supply(beth, token, web3):
    initial_supply = token.totalSupply()
    beth.transfer(token, web3.toWei(0.01, "ether"))

    assert token.totalSupply() == initial_supply + 100
