pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Base64 and other imports

contract NFTdynamicPW is ERC721Enumerable, Ownable {
  using Strings for uint256;
  string nameonart = "Architect";
  string color = "white";
  uint gridnum = 3;
  uint[] public xcordsplayers; 
  uint[] public ycordsplayers; 

  struct minterinfo{
      string name;
      string color;
      uint gridsize; 
      uint[] xcordsminting;
      uint[] ycordsminting; 
      // Coordinates start with 0,0
  }

  mapping (uint256 => minterinfo) public details;

  constructor() ERC721("ArchiDAO OnChain", "ADAO") {
    
  }

  // need to debug
  function nftdatabase (uint256 num) public view returns(string memory) {
    require(num <= totalSupply());
    minterinfo memory result = details[num];
    return(result.name);

  }

  // public
  function mint(string memory name_on_nft, string memory background_color, uint numgrid, uint[] memory xcordsplayuser, uint[] memory ycordsplayuser ) public payable {
    uint256 supply = totalSupply();
    
    nameonart = name_on_nft;
    color = background_color;
    gridnum = numgrid;
    xcordsplayers = xcordsplayuser; 
    ycordsplayers = ycordsplayuser; 
  
    

    require(supply + 1 <= 10000);

    // minterinfo memory holder = minterinfo (name_on_nft, background_color);
    minterinfo memory holder = minterinfo (nameonart, color, gridnum,xcordsplayers,ycordsplayers );
    details[supply +1] = holder;

    if (msg.sender != owner()) {
      require(msg.value >= 0.005 ether );
    }
    _safeMint(msg.sender, supply + 1);
  }

  function grid (uint256 iter, string memory colr) public view returns (string memory) {
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
        colr,
        '" x="',
        xcord,
        '" y="',
        ycord,
        '"/>'));
      }
    }
    return svgloop;
  }

  function playersgrid (uint[] memory xcordinateplayer, uint[] memory ycordinateplayer) public view returns (string memory) {
    string memory svgplayerloop = "";
    uint iterationsgrid = xcordinateplayer.length;
    for (uint k=0; k<iterationsgrid;k++){
      
        uint256 xcor = xcordinateplayer[k]*190+10;
        uint256 ycor = ycordinateplayer[k]*190+10;
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

  function buildImage(uint256 gridno, string memory col, uint[] memory xx, uint[] memory yy) public view returns(string memory){
    uint256 canvassiz = gridno*200;
    string memory canvasizz = Strings.toString(canvassiz);

    return Base64.encode(bytes(abi.encodePacked(
      '<svg width="',
      canvasizz,
      '" height="',
      canvasizz,
      '" xmlns="http://www.w3.org/2000/svg">',
      grid(gridno, col),
      playersgrid(xx,yy),
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

    minterinfo memory metagen = details[tokenId];

    // uint gridno = metagen.gridsize ; 
    //string color

    // override rectangles on grid using input here
    return string(abi.encodePacked(
      'data:application/json;base64,',
      Base64.encode(bytes(abi.encodePacked(
        '{"name":"','Mayur','",',
        '"description":"','Cool Generative NFT','",',
        '"image":"','data:image/svg+xml;base64,',
        buildImage(metagen.gridsize, metagen.color,metagen.xcordsminting, metagen.ycordsminting ),
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
