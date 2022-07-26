// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NftGame is ERC721, Ownable {
    uint256 COUNTER;

    struct nft {
        string name;
        uint256 id;
        uint256 dna;
        uint8 level;
        uint8 rarity;
    }

    nft[] public myNFT;

    event NewNft(address indexed owner, uint256 id, uint256 dna);

    function getRandomDNA (string memory _str) internal pure returns (uint256) {
        uint randomNUM = uint256(keccak256(abi.encodePacked(_str)));
        return randomNUM % 10**16;
    }

   constructor(string memory _name, string memory _symbol)
   ERC721(_name, _symbol) {}

   function createNFT (string memory _name, uint256 _dna) internal {
    nft memory NFTs = nft(_name, COUNTER, _dna, 1, 50);
    myNFT.push(NFTs);
    _safeMint(msg.sender, COUNTER);
    emit NewNft(msg.sender, COUNTER, _dna);
    COUNTER++;
   }

   function createRandomNFT (string memory _name) public {
    uint randDNA = getRandomDNA(_name);
    createNFT(_name, randDNA);
   }

   function getNFT () public view returns (nft[] memory) {
    return myNFT;
   }
        
    

}