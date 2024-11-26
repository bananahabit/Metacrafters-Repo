import {useState, useEffect} from "react";
import {ethers} from "ethers";
import atm_abi from "../artifacts/contracts/Assessment.sol/Assessment.json";

export default function HomePage() {
  const [ethWallet, setEthWallet] = useState(undefined);
  const [account, setAccount] = useState(undefined);
  const [atm, setATM] = useState(undefined);
  const [balance, setBalance] = useState(undefined);
  
  const [isLocked, setIsLocked] = useState(false);

  const [withdrawAmount, setWithdrawAmount] = useState("");
  const [depositAmount, setDepositAmount] = useState("");

  const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
  const atmABI = atm_abi.abi;
 

    const lockAccount = async () => {
      if (atm) {
        let tx = await atm.lockAccount();
        await tx.wait();
        setIsLocked(true);
        getBalance();
      }
    };

    const unlockAccount = async () => {
      if (atm) {
        let tx = await atm.unlockAccount();
        await tx.wait();
        getBalance();
      }
    };



  const getWallet = async() => {
    if (window.ethereum) {
      setEthWallet(window.ethereum);
    }

    if (ethWallet) {
      const account = await ethWallet.request({method: "eth_accounts"});
      handleAccount(account);
    }
  }

  const handleAccount = (account) => {
    if (account) {
      console.log ("Account connected: ", account);
      setAccount(account);
    }
    else {
      console.log("No account found");
    }
  }

  const connectAccount = async() => {
    if (!ethWallet) {
      alert('MetaMask wallet is required to connect');
      return;
    }
  
    const accounts = await ethWallet.request({ method: 'eth_requestAccounts' });
    handleAccount(accounts);
    
    // once wallet is set we can get a reference to our deployed contract
    getATMContract();
  };

  const getATMContract = () => {
    const provider = new ethers.providers.Web3Provider(ethWallet);
    const signer = provider.getSigner();
    const atmContract = new ethers.Contract(contractAddress, atmABI, signer);
 
    setATM(atmContract);
  }

  const getBalance = async() => {
    if (atm) {
      setBalance((await atm.getBalance()).toNumber());
      setIsLocked(await atm.isUnlocked());
    }
  }

  const deposit = async() => {
    if (atm) {
      const amount = parseFloat(depositAmount);
      if (isNaN(amount)) {
        alert("Please enter a valid amount to deposit");
        return;
      }
      else if (amount < 0) {
        alert("Please enter an amount greater than 0");
        return;
      }

      let tx = await atm.deposit(amount);
      await tx.wait()
      getBalance();
      setDepositAmount("");
    }
  }

  const withdraw = async() => {
    if (atm) {
      const amount = parseFloat (withdrawAmount);
      if (isNaN(amount)) {
        alert("Please enter a valid amount to withdraw");
        return; 
      }
      else if (amount < 0) {
        alert("Please enter an amount greater than 0");
        return;
      }
      else if (amount > balance){
        alert("Insufficient funds to withdraw");
        return;
      }

      let tx = await atm.withdraw(amount);
      await tx.wait()
      getBalance();
      setWithdrawAmount("");
    }
  }

  const initUser = () => {
    // Check to see if user has Metamask
    if (!ethWallet) {
      return <p>Please install Metamask in order to use this ATM.</p>
    }

    // Check to see if user is connected. If not, connect to their account
    if (!account) {
      return <button onClick={connectAccount}>Please connect your Metamask wallet</button>
    }

    if (balance == undefined) {
      getBalance();
    }

    return (
      <div>
        <p>Your Account: {account}</p>
        <p>Your Balance: {balance}</p>
        <p>Account is: {isLocked? "Unlocked" : "Locked"}</p>
        {!isLocked ? (
            <button onClick={unlockAccount}>Open Account</button>

            ) : (
              <>
              <button onClick={lockAccount}>Lock Account</button>
              <div>
                <input 
                  type="number" 
                  placeholder="Enter amount to withdraw" 
                  value={withdrawAmount}
                  onChange={(e) => setWithdrawAmount(e.target.value)}
                />
                <button onClick={withdraw}>Withdraw ETH</button>
              </div>

              <div>
                <input
                  type="number"
                  placeholder="Enter amount to deposit"
                  value={depositAmount}
                  onChange={(e) => setDepositAmount(e.target.value)}
                />
                <button onClick={deposit}>Deposit ETH</button>
              </div>
              </>
            )}
      
        </div>
      )
    }

  useEffect(() => {getWallet();}, []);

  return (
    <main className="container">
      <header><h1>Welcome to the Metacrafters ATM!</h1></header>
      {initUser()}
      <style jsx>{`
        .container {
          text-align: center
        }
      `}
      </style>
    </main>
  )
}
