//Done By:- Varinderjot Singh
//Develop a smart contract which will take ethers from EOA Accounts and then people can withdraw specific ethers from the contract.
// ( It will act like a bank, where you deposit money and when required you withdraw the money )

pragma solidity ^0.4.17;

contract myWallet{
    function withdraw() public {
        msg.sender.transfer(address(this).balance);
    }

    function deposit(uint256 amount) payable public {
        require(msg.value == amount);
        
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}