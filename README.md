# Cloud Token
An ERC-20 token for when you have your head in the clouds.

Deployed on Rinkeby Test Network
Contract Address: `0x02c3e2E97b3a3E05dDc78a165af72674b51B8155`

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

## Learnings

This was my first attempt at creating a smart contract after learning solidity through [cryptozombies](https://cryptozombies.io/). Luckily solidity is very similar to other languages I've played around with over the years (C++, JavaScript and Python) so the learning curve wasn't high at all. Getting accustomed to the type system, the compiler errors/warnings and the syntax only required a couple hours before it felt normal. The key takeaways I got from undertaking this project were:

1. Test
2. Test!
3. Read the docs (a.k.a RTFM)

Honestly a big part of smart contract development is testing, bugs are inevitable in any large code base, and edge cases do exist, but with a comprehensive test suite you should be able to catch a lot of the kinks during development. Even better, if you subscribe to TDD, then developing a smart contract isn't all to difficult since you have a set of standards to meet.

What's unique about this project compared to a bunch of other solidity code bases, is I decided to use a Python based tooling and testing framework called [brownie](https://github.com/eth-brownie/brownie). A majority of the Ethereum smart contract development ecosystem is heavily geared towards JavaScript, which I'm not an expert in. I've played around with Node, Mocha and Chai for BDD, and ES6 promises, but coming from a data science background, it felt more comfortable to do testing with a Python framework. This had the added benefit of allowing me to focus on really learning solidity without worrying about re-learning JS.

Reading the documentation is also a very important thing, typically I rely on auto-complete in my IDE (I mean who doesn't), but this time around I really dove deeper into the solidity docs whenever I had a question, and I also made sure to pay extra attention to the style guide to make my code base more readable.

## Next Steps

I should really build out a demo UI for my token, something simple and straight to the point (MVP). Since I'm still probably going to be stubborn and rely on Python, I'll most likely try not to use something like React (since the learning curve is too high). I'd much rather setup something simpler like a django server, with a Vue front-end.


## Special Thanks

Anthony ([@tesla809](https://github.com/tesla809/)): An amazing developer, community leader, and just an all around great guy. Always pushing for others to do their best, and delivering invaluable wisdom to the masses.
