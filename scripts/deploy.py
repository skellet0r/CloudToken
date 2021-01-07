from brownie import CloudToken, PriceFeedOracle, accounts


def main():
    acct = accounts[0]
    oracle = PriceFeedOracle.deploy({"from": acct})
    CloudToken.deploy(10 ** 9, oracle.address, {"from": acct})
