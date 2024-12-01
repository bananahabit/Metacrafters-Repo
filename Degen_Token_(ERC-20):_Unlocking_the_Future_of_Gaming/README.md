# ETHAVAX4 DEGEN TOKEN SMART CONTRACT

The degenToken Solidity smart contract implements an ERC20 token named "Degen" with symbol "DGN". This contract allows the user to choose their preferred characters based on their class, this is done through spending tokens. This contract also allows the user to mint, transfer, and check their balance. 

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/(https://remix.ethereum.org/).

Create a new file by clicking the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., DegenToken.sol). Copy and paste the following code into the file:

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DegenToken is ERC20, Ownable {

    struct Class {
        uint expReq; 
        string description;
    }

    mapping(string => Class) public classes;
    mapping(address => string[]) public myClasses;


    constructor() ERC20 ("Degen", "DGN") Ownable(msg.sender){
        classes["Mage"] = Class(20, "A spellcaster that shoots fireball from afar but has low health");
        classes["Warrior"] = Class(10, "A robust frontliner that deals low damage but has high armor and health");
        classes["Thief"] = Class(15, "A trickster that deals critical damage during a successful sneak attack");
    }

    function mintToken(address to, uint256 amount) public onlyOwner {
                require(amount > 0, "Must mint an amount greater than 0" );
                _mint(to, amount);
            }

    function transferToken(address to, uint256 amount) public {
                require(balanceOf(msg.sender) >= amount ,"You do not have enough balance to transfer");
                require(amount > 0, "Must transfer an amount greater than 0" );
                _transfer(msg.sender, to, amount);
            }

    function redeemClass(string memory classType) external{
        require(classes[classType].expReq > 0, "Class type does not exist"); 
        require(balanceOf(msg.sender) >= classes[classType].expReq, "You do not have enough experience to learn this class");
        _burn(msg.sender, classes[classType].expReq);
        myClasses[msg.sender].push(classes[classType].description);
    }

    function checkBalance() external view returns (uint) {
        return this.balanceOf(msg.sender);
    }

    function burnToken(uint256 amount) public {
            require(amount > 0, "Must burn an amount greater than 0");      
            _burn(msg.sender, amount);
        }

    function getClassDef()public view returns (string[] memory){
        return myClasses[msg.sender]; 
    }

}
```

### Contract Functions
- mintToken: Only the owner has permission to mint to accounts of their choice. 
- transferToken: Player can transfer tokens to accounts of their choice. 
- redeemClass: Allows the player to select their class.
- checkBalance: Player can check their token balance. 
- burnToken: Player can destroy their tokens.
- getClassDef: Displays the description of their chosen class. 

### Compilation

In Remix, click on the "Solidity Compiler" tab in the left-hand sidebar.
Set the "Compiler" version to 0.8.0 or any compatible version.
Click "Compile DegenToken.sol."

### Deployment
Go to the "Deploy & Run Transactions" tab in the sidebar.
Deploy the contract and interact with its functions.



## Authors

Paul Adrian T. Gernale 

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

