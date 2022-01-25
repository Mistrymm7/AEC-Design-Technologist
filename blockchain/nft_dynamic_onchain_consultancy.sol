// SPDX-License-Identifier: MIT
// Amended by HashLips

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Base64.sol";
import "hardhat/console.sol";

contract NFTdynamicPW is ERC721Enumerable, Ownable {
  using Strings for uint256;

  // uint mintprice 
  uint256 public consultancyrate = 0.002 ether;
  uint[] public redeemablehrs;

 

  // mapping (uint256 => minterinfo) public details;

  constructor() ERC721("ArchiDAO Consultancy NFT", "ACON") {
    
  }

 

  function currentConsultancyRate() public view returns(uint256) {

      console.log("Current Consultancy Rate (Finney) is", (consultancyrate*1000)/(1 ether));
      return (consultancyrate*1000/(1 ether));
 }

  function updateConsultancyRate(uint256 _newrateinFinney) public onlyOwner {
    
    consultancyrate = _newrateinFinney*1e15;
    console.log("State Update Rate (FinneyWei) is", (consultancyrate*1000)/(1 ether));
  }

  // public
  function mint(uint hrsbuy) public payable {
    uint256 supply = totalSupply();
    require(supply + 1 <= 10000);
    redeemablehrs.push(hrsbuy);

    //add balance *mint

    //REMOVE LATER
    require(msg.value >= consultancyrate*hrsbuy);

    if (msg.sender != owner()) {
      require(msg.value >= consultancyrate*hrsbuy);
    }
    _safeMint(msg.sender, supply + 1);
  }




  function buildImage(uint256 queryID) public view returns(string memory){
    return Base64.encode(bytes(abi.encodePacked(
      '<svg width="500" height="500" xmlns="http://www.w3.org/2000/svg">',
      '<rect height="500" width="500" fill="black"/>',
      '<text dominant-baseline="middle" text-anchor="middle" font-size="20" y="30%" x="50%"  fill="white">',
      '<tspan x="50%" dy="1.2em" font-size="40"> ArchiDAO </tspan>  <tspan x="50%" dy="1.2em"> AEC Metaverse and Blockchain Consultany </tspan> <tspan x="50%" dy="1.2em"> Hours Left: ',
       // Change
       redeemablehrs[queryID].toString(),
      '</tspan>  </text>',
      '</svg>'
      )));
  }

  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );
    
    return string(abi.encodePacked(
      'data:application/json;base64,',
      Base64.encode(bytes(abi.encodePacked(
        '{"name":"','ArchiDAO Consultancy NFT','",',
        '"description":"','Onchain Consultancy Metadata','",',
        '"image":"','data:image/svg+xml;base64,',
        buildImage(tokenId),
        '"}'
      )))));
  }

 
  function withdraw() public payable onlyOwner {
    // This will pay HashLips 5% of the initial sale.
    // You can remove this if you want, or keep it in to support HashLips and his channel.
    // =============================================================================
    (bool hs, ) = payable(0x943590A42C27D08e3744202c4Ae5eD55c2dE240D).call{value: address(this).balance * 5 / 100}("");
    require(hs);
    // =============================================================================
    
    // This will payout the owner 95% of the contract balance.
    // Do not remove this otherwise you will not be able to withdraw the funds.
    // =============================================================================
    (bool os, ) = payable(owner()).call{value: address(this).balance}("");
    require(os);
    // =============================================================================
  }
}
