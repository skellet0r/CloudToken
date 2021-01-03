from brownie.test import given, strategy


@given(amount=strategy("uint256", max_value=10 ** 21))
def test_transfer_decreases_sender_balance(adam, beth, token, amount):
    initial_balance = token.balanceOf(adam)
    token.transfer(beth, amount, {"from": adam})

    assert token.balanceOf(adam) == initial_balance - amount


@given(amount=strategy("uint256", max_value=10 ** 21))
def test_transfer_increases_recipient_balance(adam, beth, token, amount):
    initial_balance = token.balanceOf(beth)
    token.transfer(beth, amount, {"from": adam})

    assert token.balanceOf(beth) == initial_balance + amount


def test_transfer_emits_a_transfer_event(adam, beth, token):
    tx = token.transfer(beth, 10 ** 18, {"from": adam})

    assert "Transfer" in tx.events


def test_successful_transfer_returns_true(adam, beth, token):
    tx = token.transfer(beth, 10 ** 18, {"from": adam})

    assert tx.return_value is True
