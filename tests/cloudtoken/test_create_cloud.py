import brownie


def test_create_cloud_emits_cloud_formation(token, adam):
    tx = token.createCloud(100, 3, {"from": adam})

    assert "CloudFormation" in tx.events
    assert tx.events.count("CloudFormation") == 1


def test_create_cloud_returns_true(token, adam):
    tx = token.createCloud(100, 3, {"from": adam})

    assert tx.return_value is True


def test_create_cloud_decrements_senders_balance(token, adam):
    initial_balance = token.balanceOf(adam)
    token.createCloud(100, 3, {"from": adam})

    assert token.balanceOf(adam) == initial_balance - 100


def test_create_cloud_cloud_formation_event_values(token, adam):
    tx = token.createCloud(100, 3, {"from": adam})

    assert tx.events["CloudFormation"].values() == [tx.timestamp, 100, 3]


def test_create_cloud_fails_if_balance_not_sufficient(token, beth):
    with brownie.reverts("dev: Insufficient balance"):
        token.createCloud(100, 3, {"from": beth})
