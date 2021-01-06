import brownie


def test_withdraw_increases_ether_balance_of_owner(adam, token, web3):
    adam.transfer(token, "1 ether")
    token.withdraw(adam, "1 ether", {"from": adam})

    # due to gas fees should be close to 100 ether
    assert adam.balance() > web3.toWei(99, "ether")


def test_withdraw_decreases_ether_balance_of_token(adam, token):
    adam.transfer(token, "1 ether")
    token.withdraw(adam, "1 ether", {"from": adam})

    assert token.balance() == 0


def test_withdraw_returns_bool(adam, token):
    adam.transfer(token, "1 ether")
    tx = token.withdraw(adam, "1 ether", {"from": adam})

    assert tx.return_value is True


def test_withdraw_reverts_due_to_insufficient_balance(adam, token):
    adam.transfer(token, "1 ether")

    with brownie.reverts("dev: Insufficient ether balance"):
        token.withdraw(adam, "99 ether", {"from": adam})


def test_withdraw_only_works_for_owner(adam, beth, token):
    beth.transfer(token, "1 ether")
    tx = token.withdraw(beth, ".5 ether", {"from": adam})

    with brownie.reverts("Ownable: caller is not the owner"):
        token.withdraw(beth, "1 ether", {"from": beth})

    assert tx.return_value is True
