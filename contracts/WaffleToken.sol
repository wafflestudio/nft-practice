// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./Waffle.sol";
import "./WaffleOwnership.sol";

// @dev 와플 토큰 민팅을 위한 최종 구현체
contract WaffleToken is Waffle, WaffleOwnership {


    // @notice WaffleTokens are first minted for students in waffleStudio (https://wafflestudio.com/)
    // @dev TODO 초기화 시에 10명의 동아리원을 위한 토큰을 발행해야 합니다.
    constructor() ERC721("WaffleToken", "WFTK") {
        // TODO D_APP 개발 후 URI 연동
        setBaseURI("");

        for (uint8 i = 0; i < 10; i++) {
            string memory title = string(abi.encodePacked("waffle NFT #", Strings.toString(i)));
            _mintNewWaffle(title);
        }
    }


    // @dev 새로운 Waffle 토큰 발행
    function _mintNewWaffle(string memory title) internal {
        uint8 size;
        uint8 baseColor;
        uint8[2] memory verticals;
        uint8[2] memory horizontals;
        uint256 toppings;
        uint tokenId = _createRandomWaffle(title);
        _safeMint(msg.sender, tokenId);
    }

    // @notice bake a new waffle with your ETH
    function claim(string calldata title) external payable {
        require(msg.value == 0.00001 ether, "you need 0.00001 ETH to purchase waffle");
        _mintNewWaffle(title);
        payable(owner()).transfer(0.00001 ether);
    }
}
