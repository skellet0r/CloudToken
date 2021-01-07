from brownie import CloudToken, PriceFeedOracle, accounts

"""Chainlink Price Feed Oracles for the ETH/USD Pair
URL: https://docs.chain.link/docs/ethereum-addresses"""

ETHUSD_ORACLE_ADDRESSES = {
    "Mainnet": "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
    "Kovan": "0x9326BFA02ADD2366b30bacB125260Af641031331",
    "Rinkeby": "0x8A753747A1Fa494EC906cE90E9f37563A8AF630e",
}


def main():
    acct = accounts[0]
    oracle = PriceFeedOracle.deploy({"from": acct})
    CloudToken.deploy(10 ** 9, oracle.address, {"from": acct})
