// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ArchiDAO is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    uint public baseRate = 1 ether;
    uint public rarity = 3;

    constructor() ERC721("ArchiDAO", "ADAO") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://mysteryworld.com/tokens/";
    }

    // Allow Anyone to mint and make it payable
    function safeMint(address to) public payable {
        
        require(totalSupply() < rarity, "All NFT minted");

        require(msg.value >= baseRate, " Match upto base rate atleast");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    //Withdraw money from this smart contract
    function withdraw() public onlyOwner{
        require(address(this).balance > 0, "Nothing left");
        payable(owner()).transfer(address(this).balance);
    }


    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
