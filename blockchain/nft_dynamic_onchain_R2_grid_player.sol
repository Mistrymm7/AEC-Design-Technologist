// SPDX-License-Identifier: MIT
// Amended by HashLips

pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Base64.sol";

// Base64 and other imports

contract NFTdynamicPW is ERC721Enumerable, Ownable {
  using Strings for uint256;
 
  struct mintMomentInfo{
  
      uint16 count; 
      uint16[] allUserTileIndices;
      uint16[] galleryUserIndices;
      address[] walletaddress; 
      
  }

  mapping (uint256 => mintMomentInfo) public details;

  constructor() ERC721("ArchiDAO OnChain", "ADAO") {
    
  }

  // add public function about mintMoment info  

  // public
  function mint(uint16 count, uint16[] memory allUserTileIndices, uint16[] memory galleryUserIndices, address[] memory walletaddress ) public payable {
    
    uint256 supply = totalSupply();
 
    require(supply + 1 <= 10000);

    if (msg.sender != owner()) {
      require(msg.value >= 0.005 ether );
    }
    _safeMint(msg.sender, supply + 1);
    
    details[supply +1] = mintMomentInfo ( count, allUserTileIndices,  galleryUserIndices, walletaddress);
  }

  function grid (uint256 iter) public pure returns (string memory) {
    string memory svgloop = "";
    uint iterationsgrid = iter;
    for (uint j=0; j<iterationsgrid;j++){
      for (uint i=0; i<iterationsgrid;i++){
        uint256 xcor = i*190+10;
        uint256 ycor = j*190+10;
        
        string memory xcord = Strings.toString(xcor);
        string memory ycord = Strings.toString(ycor);
      svgloop = string(abi.encodePacked(
        svgloop, 
        '<rect height="180" width="180" fill="',
        'red',
        '" x="',
        xcord,
        '" y="',
        ycord,
        '"/>'));
      }
    }
    return svgloop;
  }


  function playersgrid (uint16 gridno, uint16[] memory galleryUserIndices) public pure returns (string memory) {
    string memory svgplayerloop = "";

    uint iterationsUserGrid = galleryUserIndices.length;
    for (uint k=0; k<iterationsUserGrid ;k++){
        
        //mod for x and divison for y
        uint16 xUserIndice = galleryUserIndices[k] % gridno;
        uint16 yUserIndice = galleryUserIndices[k] / gridno;
        
        uint256 xcor = xUserIndice*190+10;
        uint256 ycor = yUserIndice*190+10;
        string memory xcord = Strings.toString(xcor);
        string memory ycord = Strings.toString(ycor);
      svgplayerloop = string(abi.encodePacked(
        svgplayerloop, 
        '<rect height="180" width="180" fill="',
        'black',
        '" x="',
        xcord,
        '" y="',
        ycord,
        '"/>'));
      
    }
    return svgplayerloop;
  }

  function buildImage(uint16 gridno, uint16[] memory galleryUserIndices) public pure returns(string memory){
    
    uint16 canvassiz = gridno*200;
    string memory canvasizz = Strings.toString(canvassiz);

    return Base64.encode(bytes(abi.encodePacked(
      '<svg width="',
      canvasizz,
      '" height="',
      canvasizz,
      '" xmlns="http://www.w3.org/2000/svg">',
      grid(gridno),
      playersgrid(gridno, galleryUserIndices),
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

    mintMomentInfo memory momentMetada = details[tokenId];



    // override rectangles on grid using input here
    return string(abi.encodePacked(
      'data:application/json;base64,',
      Base64.encode(bytes(abi.encodePacked(
        '{"name":"','Perkins & Will','",',
        '"description":"','Decentraland Metaverse Experiments','",',
        '"image":"','data:image/svg+xml;base64,',
        buildImage(momentMetada.count, momentMetada.galleryUserIndices),
        '"}'
      )))));
  }

 
  function withdraw() public payable onlyOwner {
   
    (bool hs, ) = payable(0x943590A42C27D08e3744202c4Ae5eD55c2dE240D).call{value: address(this).balance * 5 / 100}("");
    require(hs);
   
    (bool os, ) = payable(owner()).call{value: address(this).balance}("");
    require(os);
  
  }
}
