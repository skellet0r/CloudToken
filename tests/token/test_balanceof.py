from brownie.test import given, strategy


def test_balanceof_contract_deployer_is_totalsupply(adam, token):
    total_supply = token.totalSupply()

    assert token.balanceOf(adam) == total_supply


@given(amount=strategy("uint256", max_value=10 ** 21))
def test_balanceof_sender_decreases_after_transfer(adam, beth, token, amount):
    initial_balance = token.balanceOf(adam)
    token.transfer(beth, amount, {"from": adam})

    assert token.balanceOf(adam) == initial_balance - amount


@given(amount=strategy("uint256", max_value=10 ** 21))
def test_balanceof_recipient_increases_after_transfer(adam, beth, token, amount):
    initial_balance = token.balanceOf(beth)
    token.transfer(beth, amount, {"from": adam})

    assert token.balanceOf(beth) == initial_balance + amount


def test_balanceof_other_accounts_is_zero_after_deployment(accounts, token):
    for account in accounts[1:]:
        assert token.balanceOf(account) == 0
