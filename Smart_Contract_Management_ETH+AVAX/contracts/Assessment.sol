// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract Assessment {
    address payable public owner;
    uint256 public balance;
    //
    bool public isUnlocked;


    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);
    event UnlockedAccount(); 
    event LockedAccount(); 


    constructor(uint initBalance) payable { 
        owner = payable(msg.sender); 
        balance = initBalance; 
        isUnlocked = false; 
    } 
 
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    modifier openedAccount(){ 
        require(isUnlocked, "Account is locked"); 
        _; 
    }
    
    function unlockAccount() public onlyOwner { 
        require(!isUnlocked, "Account is already unlocked");
        isUnlocked = true;
        emit UnlockedAccount(); 
    }

    function lockAccount () public onlyOwner openedAccount(){
        isUnlocked = false; 
        
        emit LockedAccount(); 
    }


    function getBalance() public view returns(uint256){
        return balance;
    }

    function deposit(uint256 _amount) public payable onlyOwner{
        uint _previousBalance = balance;

        // make sure this is the owner
        require(msg.sender == owner, "You are not the owner of this account");

        // perform transaction
        balance += _amount;

        // assert transaction completed successfully
        assert(balance == _previousBalance + _amount);

        // emit the event
        emit Deposit(_amount);
    }

    // custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public onlyOwner{
        require(msg.sender == owner, "You are not the owner of this account");
        uint _previousBalance = balance;
        if (balance < _withdrawAmount) {
            revert InsufficientBalance({
                balance: balance,
                withdrawAmount: _withdrawAmount
            });
        }

        // withdraw the given amount
        balance -= _withdrawAmount;

        // assert the balance is correct
        assert(balance == (_previousBalance - _withdrawAmount));

        // emit the event
        emit Withdraw(_withdrawAmount);
    }
}
