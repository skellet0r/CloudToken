def test_receive_increases_balance_of_sender(beth, token, web3):
    initial_balance = token.balanceOf(beth)
    beth.transfer(token, "1 ether")

    assert token.balanceOf(beth) == initial_balance + web3.toWei(1, "ether")


def test_receive_increases_total_supply(beth, token, web3):
    initial_supply = token.totalSupply()
    beth.transfer(token, "1 ether")

    assert token.totalSupply() == initial_supply + web3.toWei(1, "ether")
