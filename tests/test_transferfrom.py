import pytest
import brownie


@pytest.fixture(autouse=True, scope="module")
def set_approval(adam, beth, token):
    token.approve(beth, 10 ** 18, {"from": adam})


def test_transferfrom_descreases_owner_balance(adam, beth, token, accounts):
    owner_initial_balance = token.balanceOf(adam)
    token.transferFrom(adam, accounts[2], 10 ** 9, {"from": beth})

    assert token.balanceOf(adam) == owner_initial_balance - 10 ** 9


def test_transferfrom_increases_recipient_balance(adam, beth, token, accounts):
    recipient_initial_balance = token.balanceOf(accounts[2])
    token.transferFrom(adam, accounts[2], 10 ** 9, {"from": beth})

    assert token.balanceOf(accounts[2]) == recipient_initial_balance + 10 ** 9


def test_transferfrom_decreases_spender_allowance(adam, beth, token, accounts):
    token.transferFrom(adam, accounts[2], 10 ** 9, {"from": beth})

    assert token.allowance(adam, beth) == (10 ** 18) - (10 ** 9)


def test_transfrom_emits_tranfer_event(adam, beth, token, accounts):
    tx = token.transferFrom(adam, accounts[2], 10 ** 9, {"from": beth})

    assert "Transfer" in tx.events
    assert tx.events["Transfer"].values() == [adam, accounts[2], 10 ** 9]


def test_transfrom_returns_boolean(adam, beth, token, accounts):
    tx = token.transferFrom(adam, accounts[2], 10 ** 9, {"from": beth})

    assert tx.return_value is True


def test_transferfrom_reverts_due_to_insufficient_owner_balance(
    adam, beth, token, accounts
):
    token.approve(beth, 10 ** 24, {"from": adam})
    with brownie.reverts("dev: Insufficient balance"):
        token.transferFrom(adam, accounts[2], 10 ** 21 + 1, {"from": beth})


def test_transferfrom_reverts_due_to_insufficient_allowance(
    adam, beth, token, accounts
):
    with brownie.reverts("dev: Insufficient allowance"):
        token.transferFrom(adam, accounts[2], 10 ** 18 + 1, {"from": beth})
