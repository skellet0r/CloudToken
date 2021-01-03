from brownie.test import given, strategy


@given(
    owner=strategy("address"),
    spender=strategy("address"),
    amount=strategy("uint256"),
)
def test_allowance_returns_number_of_tokens_allowed(token, owner, spender, amount):
    token.approve(spender, amount, {"from": owner})

    assert token.allowance(owner, spender) == amount


@given(owner=strategy("address"), spender=strategy("address"))
def test_allowance_is_zero_by_default(owner, spender, token):
    assert token.allowance(owner, spender) == 0
