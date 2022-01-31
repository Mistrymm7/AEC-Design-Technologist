// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC1155, Ownable {
    

    //Set of predecided NFT 

    //index 0; Metaversedesign, 1: Developer, 2: NFT Consu hrs
    uint256[] public variousservices = [150,50,100];
    uint256[] public servicehrstracker = [0,0,0];
    uint256[] public consultancyrates = [0.05 ether,0.1 ether,0.5 ether];

    //To do : 
    // Add new service, (Done)
    // Update Consultancy rate,  (Done)
    // Svg embeding of state, 
    // Develop dapp that automatically determines payment rate, 
    // Service tip jar 
    // IPFS Conection
    // Set Metadata

    constructor() ERC1155("https://api.mysite.com/tokens/{id}") {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

        function uint2str(
            uint256 _i
            )
            internal
            pure
            returns (string memory str)
            {
                if (_i == 0)
                {
                    return "0";
                }
            uint256 j = _i;
            uint256 length;
                while (j != 0)
                {
                    length++;
                    j /= 10;
                }
            bytes memory bstr = new bytes(length);
            uint256 k = length;
            j = _i;
                while (j != 0)
                {
                    bstr[--k] = bytes1(uint8(48 + j % 10));
                    j /= 10;
                }
            str = string(bstr);
        }

    function mint(uint256 id, uint256 amount)
        public
        payable
    {
        require(id <= variousservices.length,"Token doesnt exist o" );
        require(id > 0,"Token doesnt exist o");
        uint256 index = id-1;

        require(servicehrstracker[index] + amount <= variousservices[index], "Exceeding supply");

        uint256 val = amount * consultancyrates[index];

        // Add payment within 10% buffer for tips, Service tips jar, Is it possible the actual variable state in error as log



        string memory errorvaluecompute = string(abi.encodePacked('Value should be atleast ',uint2str(val*1000/(1 ether)),' finney' ));
        require(msg.value >= amount * consultancyrates[index], errorvaluecompute);
        //
        _mint(msg.sender, id, amount, "");
        servicehrstracker[index] += amount;
    }

    function withdraw() public onlyOwner{
        require(address(this).balance >0, "Bro, you Broke !!");
        payable(owner()).transfer(address(this).balance);
    }
    
    function addoneserive (uint256 total_hrs_supply, uint rate_finney) public onlyOwner{
        variousservices.push(total_hrs_supply);
        consultancyrates.push(rate_finney*10**15);
        servicehrstracker.push(0);
    }

    function updateService (uint256 id, uint new_rate_finney) public onlyOwner returns (uint){
        
        consultancyrates[id] = new_rate_finney*10**15;

        return (consultancyrates[id]/(10**15));
        
    }

     mapping (uint => uint[]) rateread;

}
