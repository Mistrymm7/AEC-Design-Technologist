// SPDX-License-Identifier: MIT
// Amended by HashLips

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./10_Base64.sol";

contract NFTonchainsvg is ERC721Enumerable, Ownable {
  using Strings for uint256;

  constructor() ERC721("ArchiDAO OnChain", "ADAO") {
    
  }

  // public
  function mint() public payable {
    uint256 supply = totalSupply();
    
   
    
    require(supply + 1 <= 10000);

    if (msg.sender != owner()) {
      require(msg.value >= 0.005 ether );
    }
    _safeMint(msg.sender, supply + 1);
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
    
    return "";
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
