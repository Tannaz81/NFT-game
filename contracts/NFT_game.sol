// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NftGame is ERC721, Ownable {
    uint256 COUNTER;

    uint256 fee = 0.001 ether;

    struct nft {
        string name;
        uint256 id;
        uint256 dna;
        uint8 level;
        uint8 rarity;
    }

    nft[] public myNFT;

    event NewNft(address indexed owner, uint256 id, uint256 dna);

    function createRandomNUM(uint256 _mod) internal view returns (uint256) {
        uint randomNUM = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));
        return randomNUM % _mod;
    }

    function updateFee (uint256 _fee) external onlyOwner() {
        fee = _fee;
    }

    function withdraw () external payable onlyOwner() {
        address payable _owner = payable(owner());
        _owner.transfer(address(this).balance);
    }

   constructor(string memory _name, string memory _symbol)
   ERC721(_name, _symbol) {}

   function createNFT (string memory _name) internal {
    uint8 randRarity = uint8(createRandomNUM(100));
    uint randDNA = createRandomNUM(10**16);
    nft memory NFTs = nft(_name, COUNTER, randDNA, 1, randRarity);
    myNFT.push(NFTs);
    _safeMint(msg.sender, COUNTER);
    emit NewNft(msg.sender, COUNTER, randDNA);
    COUNTER++;
   }

   function createRandomNFT (string memory _name) public payable {
    require(msg.value == fee, "incorrect fee");
    createNFT(_name);
   }

   function getNFT () public view returns (nft[] memory) {
    return myNFT;
   }
        
    

}