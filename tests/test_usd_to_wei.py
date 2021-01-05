import pytest


cases = [(1000 * 10 ** 8, 8), (12345 * 10 ** 6, 6), (32432 * 10 ** 42, 42)]


# doing property based testing with 'eth_usd' as uint256 and 'decimals' as uint8
# raises an error because the largest possible value in solidity is 2 ** 256 - 1
# TODO: Make property test which doesn't error out
@pytest.mark.parametrize("eth_usd,decimals", cases)
def test_usd_to_wei_returns_correct_amount(token, eth_usd, decimals):
    power = decimals + 18
    one_usd_in_wei = (10 ** power) // eth_usd

    assert token.usd_to_wei(eth_usd, decimals) == one_usd_in_wei
