# TokenConverter Smart Contract

## Purpose
The TokenConverter Smart Contract is designed to facilitate the conversion of one ERC20 token (Token 1) to another ERC20 token (Token 2) with a configurable conversion fee. It allows users to exchange their tokens while deducting a fee for the conversion. This smart contract provides transparency and security for token conversions on the Binance Smart Chain (BSC).

## How It Works
The TokenConverter smart contract works by receiving an amount of Token 1 from the user, converting it to Token 2 at a predefined conversion rate, deducting a fee in Token 1, and transferring the converted Token 2 back to the user. All conversion records are stored in the contract for auditing purposes.

### Unique Functionality
One unique feature of this contract is the ability to track user balances in Token 1 using a mapping. This allows users to check their token balances within the contract, providing greater visibility and control over their assets.

## Installation and Usage

### Prerequisites
- Node.js and npm (Node Package Manager)
- Truffle Framework
- Binance Smart Chain Wallet (e.g., MetaMask) with BSC testnet or mainnet tokens

### Installation
1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/Jaeson-gram/Solidity-BNB-Chain-Development-Bootcamp-Final-Project
   cd token-converter
Install project dependencies:

bash
Copy code
npm install
Running the Smart Contract
Compile the smart contract:

bash
Copy code
truffle compile
Migrate the contract to the desired network (BSC testnet or mainnet). Update the truffle-config.js or truffle-config.bsc.js file with your configuration.

bash
Copy code
truffle migrate --network bsc
Testing the Smart Contract
Run the Truffle tests to ensure contract functionality:

bash
Copy code
truffle test
Interacting with the Smart Contract
Connect your BSC-compatible wallet (e.g., MetaMask) to the Binance Smart Chain.

Visit the DApp front-end (HTML file) in your web browser.

Use the DApp interface to interact with the TokenConverter smart contract, convert tokens, and check your balances.

Terminal Commands (PowerShell or Command Line for Windows)
Replace your-username with your GitHub username in the clone command.
Ensure you have the required dependencies installed.
License
This project is licensed under the MIT License. See the LICENSE file for details.
