// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTCollection is ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    event NewNFTMinted(address sender, uint256 tokenId);

    constructor() ERC721("De Geest Van Gaston - TEST", "TESTING") {}

    function airdrop(address[] calldata to) public onlyOwner {
        console.log("Starting airdrop...");
        for (uint256 i = 0; i < to.length; i++) {
            _mintSingleNFT(to[i]);
        }
        console.log("Finished airdrop...");
    }

    function _mintSingleNFT(address wAddress) private {
        uint256 tokenId = _tokenIds.current();
        _safeMint(wAddress, tokenId);
        _tokenIds.increment();
        emit NewNFTMinted(msg.sender, tokenId);
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(super._exists(_tokenId), "token doesnt exist");
        return
            "https://ipfs.io/ipfs/QmeB9xVGcMVikL8ET7tk12SnCGvEcKFzuvRWP72Gfi264x?filename=metadata.json";
    }
}
