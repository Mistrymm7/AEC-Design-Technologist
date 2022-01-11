// SPDX-License-Identifier: MIT
// Amended by HashLips

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./10_Base64.sol";

contract NFTdynamicPW is ERC721Enumerable, Ownable {
  using Strings for uint256;
  string nameonart = "Architect";
  string color = "white";

  struct minterinfo{
      string name;
      string color;
  }

  mapping (uint256 => minterinfo) public details;

  constructor() ERC721("ArchiDAO OnChain", "ADAO") {
    
  }

  // need to debug
  function nftdatabase (uint256 num)public returns(string memory) {
    require(num <= totalSupply());
    minterinfo memory result = details[num];
    return(result.name);

  }

  // public
  function mint(string memory name_on_nft, string memory background_color) public payable {
    uint256 supply = totalSupply();
    
    nameonart = name_on_nft;
    color = background_color;
  
    

    require(supply + 1 <= 10000);

    // minterinfo memory holder = minterinfo (name_on_nft, background_color);
    minterinfo memory holder = minterinfo (nameonart, color);
    details[supply +1] = holder;

    if (msg.sender != owner()) {
      require(msg.value >= 0.005 ether );
    }
    _safeMint(msg.sender, supply + 1);
  }

  function buildImage() public view returns(string memory){
    return Base64.encode(bytes(abi.encodePacked(
      '<svg width="500" height="500" xmlns="http://www.w3.org/2000/svg">',
      '<rect height="500" width="500" fill="',
      color,
      '"/>',
      '<text dominant-baseline="middle" text-anchor="middle" font-size="24" y="50%" x="50%"  fill="#000000">',
      nameonart,
      '</text>',
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
        '{"name":"','Mayur','",',
        '"description":"','Cool Generative NFT','",',
        '"image":"','data:image/svg+xml;base64,',
        buildImage(),
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
