// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ERC721.sol";
import "./Ownable.sol";

contract WaffleToken is Ownable, ERC721{

    struct Metadata {
        uint8 color;
        uint8 size;
        string title;
    }
    
    mapping(uint256 => Metadata) id_to_WaffleToken;
    
    constructor() ERC721("WaffleToken", "WFTK") {
  	
  	    mint(1, 1, "First Token");
  	    mint(2, 1, "First Token");
          //
          //
          //
    }


    function mint(uint8 color, uint8 size, string memory title) internal{
        uint256 tokenId = id(color, size);

        id_to_WaffleToken[tokenId] = Metadata(color, size, title);
        _safeMint(msg.sender, tokenId);
    }

    function claim(uint8 color, uint8 size, string calldata title) external payable {
        require(msg.value == 0.00001 ether, "claiming a date costs 10 finney");

        // Condition for 

        mint(color, size, title);
        payable(owner()).transfer(0.0001 ether);
    }

}

    
