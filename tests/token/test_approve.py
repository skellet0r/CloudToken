def test_approve_sets_allowance_of_spender(adam, beth, token):
    token.approve(beth, 10 ** 18, {"from": adam})

    assert token.allowance(adam, beth) == 10 ** 18


def test_approve_can_reset_allowance_of_spender(adam, beth, token):
    initial_allowance = token.allowance(adam, beth)
    token.approve(beth, 10 ** 18, {"from": adam})
    first_update = token.allowance(adam, beth)
    token.approve(beth, 0, {"from": adam})
    second_update = token.allowance(adam, beth)

    assert initial_allowance == 0
    assert first_update == 10 ** 18
    assert second_update == 0


def test_approve_changes_allowance_of_spender(adam, beth, token):
    token.approve(beth, 10 ** 18, {"from": adam})
    token.approve(beth, 10 ** 9, {"from": adam})

    assert token.allowance(adam, beth) == 10 ** 9


def test_approve_emits_approval_event(adam, beth, token):
    tx = token.approve(beth, 10 ** 18, {"from": adam})

    assert "Approval" in tx.events
    assert tx.events["Approval"].values() == [adam, beth, 10 ** 18]
