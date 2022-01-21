// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// @dev 와플 NFT 코어 컨트랙트. 프로퍼티 정의 및 실행 로직 구성
contract Waffle is Ownable {

    /**
        title: 와플 이름
        size: 와플 크기 (1부터 시작)
        baseColor: 와플 빵 색
        verticals: 가로 줄
        horizontals: 세로 줄
        toppings: 와플 토핑 (토큰 dna)

        === verticals & horizontals
        - msb => 1~5 (선 긋는 위치)
         가로 * 세로 선 긋는 조합 = 100 가지 ( 1~5 중 2개, 5C2 = 10 )
        - lsb => 색상 16개 (x0 ~xF)
        - (uint8) horizontals[0] = x01 ~ xF5
        @dev TODO 프로퍼티 확장 및 애플리케이션 형태를 고려한 도메인 설계
    */
    struct MetaData {
        string title;
        uint8 size;
        uint8 baseColor;
        uint8[2] verticals;
        uint8[2] horizontals;
        uint256 toppings;
    }

    MetaData[] public waffles;
    mapping(uint256 => address) public waffleToOwner;
    mapping(address => uint256) ownerWaffleCount;

    // @dev TODO 와플 프로퍼티를 표현해줄 수 있는 애플리케이션 연동
    string private _currentBaseURI;

    function setBaseURI(string memory baseURI) public onlyOwner {
        _currentBaseURI = baseURI;
    }

    /**
        baseColor, size 결정 로직 (?)
        @dev TODO 새로운 와플 발행, 발행 세부 로직 고도화
    */
    function _createRandomWaffle(string memory title) internal returns (uint) {
        uint8 size = 1;
        uint8 baseColor = 1;
        uint256 toppings = _getRandom(title);
        uint8[2] memory verticals;
        verticals[0] = _getRandomLine(title);
        verticals[1] = _getRandomLine(title);
        uint8[2] memory horizontals;
        horizontals[0] = _getRandomLine(title);
        horizontals[1] = _getRandomLine(title);
        waffles.push(MetaData(title, size, baseColor, verticals, horizontals, toppings));
        uint tokenId = waffles.length - 1;
        waffleToOwner[tokenId] = msg.sender;
        ownerWaffleCount[msg.sender]++;
        return tokenId;
    }

    function _getRandomLine(string memory title) internal returns(uint8) {
        return uint8(_getRandom(title)) % 5 + 1;
    }


    // @dev pseudo random 함수
    function _getRandom(string memory title) internal returns(uint256) {
        return uint(keccak256(abi.encode(block.timestamp, msg.sender, title)));
    }
}