pragma solidity ^0.8.4;

contract Bank{
    
    mapping(address=> uint) public accounts;

    modifier checkFunds(uint _amount){
        require(_amount*(10**18) <= accounts[msg.sender], "Not sufficient funds");
        accounts[msg.sender] = accounts[msg.sender]- (_amount*(10**18));
        _;
    }

    modifier minDeposit(uint _amount){
        require( _amount >= 10 ether, "Deposit atleast 10 eth");
        _;
    }

    function deposit() public payable minDeposit(msg.value) {
        accounts[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public checkFunds(_amount){
        //could be a better way to structure this
        payable(msg.sender).transfer(_amount*(10**18));
        //subtract amount from account (Figure out why it balance didnt update here)
        //accounts[msg.sender] = accounts[msg.sender]- (msg.value*(10**18));
        
    }

    function checkBal() public view returns(uint){
        //Total treasury on this smart contract
        return( address(this).balance / (10**18));
    }



}
