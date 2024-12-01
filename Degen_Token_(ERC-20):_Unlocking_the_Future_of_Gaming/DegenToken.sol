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




