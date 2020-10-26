pragma solidity >=0.5.13 > 0.7.3;

contract CsLotterySystem{
    
    address owner;
    mapping(address => uint) public addressOfLotteryParticipants;
    address[] addressOfParticipant;
    
    constructor()public{
        owner = msg.sender;
    }
    
    function recieveEtherForParticipant()payable public{
        require(msg.value>=1 ether,"You require minimum 1 ether to participate in this lottery");
        require(contains(msg.sender)==0,"You are already a part of the lottery");
        addressOfLotteryParticipants[msg.sender] =msg.value;
        addressOfParticipant.push(msg.sender);
    }
    
    
    function randomNumberFunction() private onlyOwner returns(uint){
        uint randomNumber = uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,msg.sender,"Varinder", addressOfParticipant))) % addressOfParticipant.length;
        return(randomNumber);
    }
    
    function transferEtherToWinner()public onlyOwner{
        uint randomWinner = randomNumberFunction();
        address payable winner = payable(addressOfParticipant[randomWinner]);
        winner.transfer(address(this).balance);
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner,"Owner only has access to this");
        _;
    }
    
    function contains(address _addr) private onlyOwner returns(uint){
        return addressOfLotteryParticipants[_addr];
    }
    
}