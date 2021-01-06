# Cloud Token
An ERC-20 token for when you have your head in the clouds.

Libraries/Utilities Used:

- [Brownie](https://github.com/eth-brownie/brownie): A Python-based development and testing framework for smart contracts targeting the Ethereum Virtual Machine.
- [Solidity](https://github.com/ethereum/solidity): Solidity is a statically-typed curly-braces programming language designed for developing smart contracts that run on the Ethereum Virtual Machine.
- [Ganache](https://github.com/trufflesuite/ganache): Personal blockchain for Ethereum development.
- [Pytest](https://github.com/pytest-dev/pytest/): The pytest framework makes it easy to write small tests, yet scales to support complex functional testing.
- [Conda](https://github.com/conda/conda): Conda is a cross-platform, language-agnostic binary package manager.
- [Chainlink](https://chain.link/): Chainlink's decentralized oracle network provides reliable, tamper-proof inputs and outputs for complex smart contracts on any blockchain.
- [OpenZeppelin](https://openzeppelin.com/): OpenZeppelin provides security products to build, automate, and operate decentralized applications.

## Getting Started

If you'd like to build on the work here, you can clone this repository locally and follow the steps below to continue development.

Required dependencies:

- Conda

1. Clone the repository

   ```bash
   $ git clone https://github.com/skellet0r/CloudToken.git
   $ cd CloudToken
   ```

2. Create your environment

   ```bash
   $ conda create env -f environment.yml
   ```

3. Activate environment

   ```bash
   $ conda activate CloudToken
   ```

4. :rocket: Have fun!

### Running the Test Suite

To run the test suite from the project root, activate the `CloudToken` virtual environment, and then run the following command.

```bash
$ brownie test -n auto -C
```

This will run the entire test suite, utilizing your extra processors to distribute the tests and finish them quicker. It will also compile a coverage report which you can view by typing the following command, with your virtual environment active.

```bash
$ brownie gui
```

## Special Thanks

Anthony (@tesla809): An amazing developer, community leader, and just an all around great guy. Always pushing for others to do their best, and delivering invaluable wisdom to the masses.
