pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// @dev 와플 NFT 코어 컨트랙트. 프로퍼티 정의 및 실행 로직 구성
contract Waffle is Ownable {

    // @dev TODO 프로퍼티 확장 및 애플리케이션 형태를 고려한 도메인 설계
    struct MetaData {
        uint8 color;
        uint8 size;
        uint32 toppings;
        string title;
    }

    mapping(uint256 => MetaData) public idToWaffle;
    mapping(uint256 => address) public waffleToOwner;
    mapping(address => uint256) ownerWaffleCount;

    // @dev TODO 와플 프로퍼티를 표현해줄 수 있는 애플리케이션 연동
    string private _currentBaseURI;

    function setBaseURI(string memory baseURI) public onlyOwner {
        _currentBaseURI = baseURI;
    }
}