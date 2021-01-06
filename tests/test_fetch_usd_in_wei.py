"""Conversion rates with Mocked Price Feed reference
1     ETH = 100 USD | 10 ** 18 wei = 100 USD
.01   ETH =   1 USD | 10 ** 16 wei =   1 USD
.0001 ETH = .01 USD | 10 ** 14 wei = .01 USD
"""


def test_fetch_usd_in_wei_returns_correct_amount(token):
    assert token.fetchUsdInWei() == 10 ** 16
