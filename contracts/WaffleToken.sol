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
    function _mintWaffle(uint8[] memory loc, uint8 color, string memory title) internal {

        uint256 tokenId = id(loc); 
        
        idToWaffle[tokenId] = Waffle(color, size, title);
        _safeMint(msg.sender, tokenId); // 발행!
    }

    // @dev TODO 랜덤한 Waffle 토큰 발행 로직 설계
    function mintRandomWaffle(uint8[] memory loc) public {

        uint8 color = _getRandom();
        string title = "TBD";

        for (uint i=0; i<4; i++){
            loc[i] = _getRandom();
        }
	    // x축끼리, y축끼리 중복되는 경우 처리
        while(loc[0]==loc[1]) loc[1] = _getRandom();
        while(loc[2]==loc[3]) loc[3] = _getRandom();
        
        _mintWaffle(loc, color, title);
    }

    // @notice bake a new waffle with your ETH
    // @dev TODO 새로운 와플 발행, 발행 세부 로직 설계
    function claim(uint8 color, uint8 size, string calldata title) external payable {
        require(msg.value == 0.00001 ether, "you need 0.00001 ETH to purchase waffle");
        _mintWaffle(color, size, title);
        payable(owner()).transfer(0.0001 ether);
    }

	// id = 좌표들과 color로 총 5자리 구성
    function id(uint8[] memory loc, uint8 color) internal returns (uint256){
        uint256 res = loc[0] + loc[1]*10 + loc[3]*100 + loc[4]*1000 + color*10000;
        return res;
    }

	// 랜덤함수
    function _getRandom() internal returns(uint8){
        uint randNonce = 0;
        uint8 random = uint8(uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % 6)+1; // randrange(1~6)
        return random;
    }

}
