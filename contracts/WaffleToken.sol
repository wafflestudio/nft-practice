pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract WaffleToken is Ownable, ERC721{

    struct Metadata { //우리가 설정할 특성들
        uint8 color;
        uint8 size;
        string title;
    }

    // 흔히 생각하는 NFT에 이미지 걸거나 아이템 거는건 이 부분에서 따로 db나 서버로 연결해주는거라고 합니다.
    mapping(uint256 => Metadata) id_to_WaffleToken; // 와플토큰의 id를 딕셔너리 식의 자료구조로 만들어주고

    constructor() ERC721("WaffleToken", "WFTK") { // 생성자

        mint(1, 1, "First Token");
        mint(2, 1, "First Token");
        // 여기에 처음 필요한 만큼 발행하면 될 것 같습니다.
    }

    function mint(uint8 color, uint8 size, string memory title) internal{
        uint256 tokenId = id(color, size); // 발행할때 아이디 정해지는 방식
        id_to_WaffleToken[tokenId] = Metadata(color, size, title);
        _safeMint(msg.sender, tokenId); // 발행!
    }

    function claim(uint8 color, uint8 size, string calldata title) external payable {
        require(msg.value == 0.00001 ether, "claiming a date costs 10 finney");
        // Condition for
        mint(color, size, title);
        payable(owner()).transfer(0.0001 ether);
    }

    function id(){
        // 아이디 정해지는 로직
    }
}