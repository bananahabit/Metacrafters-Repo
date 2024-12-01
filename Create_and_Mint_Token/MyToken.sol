// SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

    contract MyToken is ERC20, Ownable{

        constructor() ERC20 ("TOKEN", "TKN") Ownable(msg.sender){
        }

        function mintToken(address to, uint256 amount) public onlyOwner {
            require(amount > 0, "Must mint an amount greater than 0" );
            _mint(to, amount);
        }

        function burnToken(uint256 amount) public {
            require(amount > 0, "Must burn an amount greater than 0");      
            _burn(msg.sender, amount);
        }

        function transferToken(address to, uint256 amount) public {
            require(balanceOf(msg.sender) >= amount ,"You do not have enough balance to transfer");
            require(amount > 0, "Must transfer an amount greater than 0" );
            _transfer(msg.sender, to, amount);
        }
    }
