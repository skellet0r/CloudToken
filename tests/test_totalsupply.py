from brownie.test import given, strategy


@given(amount=strategy("uint256"))
def test_totalsupply_initial_supply_is_correct(CloudToken, adam, amount):
    token = adam.deploy(CloudToken, amount)

    assert token.totalSupply() == amount


@given(amount=strategy("uint256", max_value=10 ** 21))
def test_totalsupply_not_altered_after_transfer(CloudToken, adam, beth, amount):
    supply = 10 ** 21
    token = adam.deploy(CloudToken, supply)
    token.transfer(beth, amount, {"from": adam})

    assert token.totalSupply() == supply
