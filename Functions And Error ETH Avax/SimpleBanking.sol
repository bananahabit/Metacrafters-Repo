// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SimpleBanking {

    uint public CurrentBalance = 0; 

    function DepositFund (uint _val) public{
        require (_val > 0, "Please insert more than 0 to your account."); 
        uint PreviousBalance = CurrentBalance;
        CurrentBalance += _val;

        assert (CurrentBalance > PreviousBalance); 
    }

    function WindrawFund (uint _val) public{
        require (_val > 0, "Withdraw an amount greater than 0."); 
        uint PreviousBalance = CurrentBalance; 
        
        if (_val > CurrentBalance){
            revert("You do not have enough balance to withdraw that amount."); 
        }
        CurrentBalance -= _val; 

        assert (CurrentBalance < PreviousBalance || CurrentBalance == 0); 
    } 
}


