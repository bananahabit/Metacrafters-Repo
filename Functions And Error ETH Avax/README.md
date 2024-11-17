# ETH + AVAX : Functions and Errors

This project is an example of a smart contract that uses require(), assert() and revert() statements. 

## Description

SimpleBanking is a simple contract that allows a user to demonstrate withdrawing from an ATM. 

The contract contains the following functions DepositFund() and WindrawFund().

`DepositFund(_val)`, allows the user to insert a certain amount greater than 0 to their account. It takes in a uint parameter `_val` to store the value. 

`WindrawFund(_val)`, allows the user to take out an amount from their account, given that it is greater than or equal to their current balance and must be greater than 0. It also takes in the uint parameter `_val` to update the remaining balance. 

## Getting Started

1. To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

2. Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with the name "SimpleBanking" and a .sol extension (e.g., SimpleBanking.sol). Copy and paste the code into the file. 

3. To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.13" (or another compatible version), and then click on the "Compile SimpleBanking.sol" button.

4. Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "SimpleBanking" contract from the dropdown menu, and then click on the "Deploy" button.

5. Once the contract is deployed, you can interact with it by clicking the "Deploy & run transactions" in the left-hand sidebar and clicking the "Deploy" button. In the Deployed Contracts section, click the drop down button for the "Deployed Contract" and interact with the deposit and withdraw buttons. Remember, you cannot withdraw an amount greater than your remaining balance, similar in real life.  

## Authors

Paul Adrian T. Gernale - FEU Tech
@bananahabit


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
