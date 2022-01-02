pragma solidity ^0.8.4;

contract MM{
    
    //basic types bool, uinit, init, string, address
    bool boolean = true;
    uint256 money= 20000;
    string starter = "ArchiDAO to the Moon";
    address account = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    // construction
    address owner;
    constructor() payable{
    owner = msg.sender;
    }

    // array
    string[] dao = ["awesome", "cutting edge", "radical"];
    uint256[] projectbudget = [1000,25000, 3500];

    // struct - similar to class
    struct Persondata {
        string firstName;
        string lastName;
        uint age;
        string city;
    }

    // instantiate
    Persondata mayur;
    Persondata nondefault;

    // define values
    function queryinfo(uint256 _id) private {
        if (_id== 0){
            mayur = Persondata({firstName:"Mayur", lastName:"Mistry", age:26,city:"Chicago"});
        } else {
            nondefault = Persondata({firstName:"ABC", lastName:"XYZ", age:29,city:"Mars"});
        }
    }

    //mapping
    mapping(address => uint)  balanceacc;
    function checkBalance() private{
        balanceacc[account] = 50;
    }

    // not working uint public senderBalance = msg.value; 

    //conditions
    function changeOwner (address newHolder) private {
        require(msg.sender == owner, "Only owner can change");
        owner = newHolder; 
       

    }

    //Check balance on address of smart contract
    function contractBalance() public view returns (uint){
        return(address(this).balance);
    }

    //events and modifiers
    event userinfo(address _user, uint _amount);

    modifier oneEther(){
        require(msg.value == 100 wei);
        _;
    }

    function sendminEth() public payable oneEther(){
        emit userinfo(msg.sender, msg.value);
    }

    //memory (variables are forgotten,saves in gas cost) and storage (replaces the original allocated array)

    uint[] public ogarray;

    function changeValue() public {

        ogarray.push(5);
        ogarray.push(8);

        // uint[] storage copiedarray = ogarray; (Replaces) Holds state variables and doesnt go away
        uint[] memory copiedarray = ogarray; 
        copiedarray[0] = 2;
    }

}
