from brownie.test import given, strategy


# this is also a valid test of the _mint private function
# however that function is not exposed externally
@given(amount=strategy("uint256"))
def test_totalsupply_initial_supply_is_correct(CloudToken, adam, amount, oracle):
    token = adam.deploy(CloudToken, amount, oracle.address)

    assert token.totalSupply() == amount


@given(amount=strategy("uint256", max_value=10 ** 21))
def test_totalsupply_not_altered_after_transfer(CloudToken, adam, beth, amount, oracle):
    supply = 10 ** 21
    token = adam.deploy(CloudToken, supply, oracle.address)
    token.transfer(beth, amount, {"from": adam})

    assert token.totalSupply() == supply
