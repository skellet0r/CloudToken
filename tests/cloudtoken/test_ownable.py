def test_contract_originator_is_owner(adam, beth, token):
    assert token.owner() == adam
    assert token.owner() != beth
