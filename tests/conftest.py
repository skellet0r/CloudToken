import pytest


@pytest.fixture(scope="module")
def adam(accounts):
    """Account used to deploy the contract"""
    return accounts[0]


@pytest.fixture(scope="module")
def beth(accounts):
    """Secondary account to interact with"""
    return accounts[1]


@pytest.fixture(scope="module")
def oracle(adam, PriceFeedOracle):
    """Deploy a mocked price feed oracle"""
    return adam.deploy(PriceFeedOracle)


@pytest.fixture(scope="module")
def token(adam, oracle, CloudToken):
    """Deploy the contract and return it"""
    return adam.deploy(CloudToken, 10 ** 21, oracle.address)


@pytest.fixture(autouse=True)
def isolate(fn_isolation):
    """Isolate each function"""
    pass
