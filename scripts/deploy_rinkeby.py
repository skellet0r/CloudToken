import os
from brownie import CloudToken, accounts

"""Chainlink Price Feed Oracles for the ETH/USD Pair
URL: https://docs.chain.link/docs/ethereum-addresses"""

ETHUSD_ORACLE_ADDRESSES = {
    "Mainnet": "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419",
    "Kovan": "0x9326BFA02ADD2366b30bacB125260Af641031331",
    "Rinkeby": "0x8A753747A1Fa494EC906cE90E9f37563A8AF630e",
}

DEV_ETH_PRIVATE_KEY = os.getenv("DEV_ETH_PRIVATE_KEY")
DEPLOYER = accounts.add(private_key=DEV_ETH_PRIVATE_KEY)


def main():
    CloudToken.deploy(10 ** 18, ETHUSD_ORACLE_ADDRESSES["Rinkeby"], {"from": DEPLOYER})
