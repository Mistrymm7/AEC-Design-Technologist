pragma solidity ^0.8.4;

contract MM{
    
    //basic types bool, uinit, init, string, address
    bool boolean = true;
    uint256 money= 20000;
    string starter = "ArchiDAO to the Moon";
    address account = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    // array
    string[] public dao = ["awesome", "cutting edge", "radical"];
    uint256[] public projectbudget = [1000,25000, 3500];

    // struct - similar to class
    struct Persondata {
        string firstName;
        string lastName;
        uint age;
        string city;
    }

    // instantiate
    Persondata public mayur;
    Persondata public nondefault;

    // define values
    function queryinfo(uint256 _id) public{
        if (_id== 0){
            mayur = Persondata({firstName:"Mayur", lastName:"Mistry", age:26,city:"Chicago"});
        } else {
            nondefault = Persondata({firstName:"ABC", lastName:"XYZ", age:29,city:"Mars"});
        }
        

    }



}
