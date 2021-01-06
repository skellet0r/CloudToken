def test_oracle_returns_decimals_equals_eight(oracle):
    assert oracle.decimals() == 8


def test_oracle_price_feed_returns_eth_usd_conversion_is_hundred(oracle):
    _, b, _, _, _ = oracle.latestRoundData()
    assert b == 100_00000000
