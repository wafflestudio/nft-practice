pragma solidity ^0.8.0;

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
            mintRandomWaffle();
        }
    }

    // @dev 새로운 Waffle 토큰 발행
    function _mintWaffle(uint8 color, uint8 size, string memory title) internal {
        uint256 tokenId = id(color, size); // 발행할때 아이디 정해지는 방식
        idToWaffle[tokenId] = Waffle(color, size, title);
        _safeMint(msg.sender, tokenId); // 발행!
    }

    // @dev TODO 랜덤한 Waffle 토큰 발행 로직 설계
    function mintRandomWaffle() public {

    }

    // @notice bake a new waffle with your ETH
    // @dev TODO 새로운 와플 발행, 발행 세부 로직 설계
    function claim(uint8 color, uint8 size, string calldata title) external payable {
        require(msg.value == 0.00001 ether, "you need 0.00001 ETH to purchase waffle");
        _mintWaffle(color, size, title);
        payable(owner()).transfer(0.0001 ether);
    }

    function id(){
        // 아이디 정해지는 로직
    }
}