// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import { Base64 } from "./libraries/Base64.sol";

contract NFTCollection is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    event NewNFTMinted(address sender, uint256 tokenId);

    constructor() ERC721("De Geest Van Gaston - TEST", "GVG") {}

    function publicMint (address to, string calldata name) public onlyOwner {
        uint256 tokenId = _tokenIds.current();
        string memory json = _getTokenUri(tokenId, to, name);
        string memory _tokenUri = string(abi.encodePacked("data:application/json;base64,", json));
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, _tokenUri);
        _tokenIds.increment();
        emit NewNFTMinted(msg.sender, tokenId);
    }

    function airdrop(address[] calldata to) public onlyOwner {
        // Expensive function, this should be used for small amount
        for (uint256 i = 0; i < to.length; i++) {
            _mintSingleNFT(to[i]);
        }
    }

    function _mintSingleNFT(address wAddress) private {
        uint256 tokenId = _tokenIds.current();
        _safeMint(wAddress, tokenId);
        _tokenIds.increment();
        emit NewNFTMinted(msg.sender, tokenId);
    }

    function _getTokenUri(uint256 _tokenId, address to, string calldata name) private view returns(string memory) {
        require(super._exists(_tokenId), "token doesnt exist");
        return Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "De Geest Van Gaston',
                        _tokenId,
                        '", "symbol": "GVG",',
                        '"description": "A highly acclaimed collection of squares.",',
                        '"image": "ipfs://QmX6ZwcrANWFcA2GaAwLyyiXrzTFVDRrFYcXmSbKwDZef1',
                        '"external_url": "https://www.degrotepost.be/agenda/3112/Ghost_Tom_Ternest_De_Grote_Post/De_Geest_van_Gaston",',
                        '"properties": {"participant:" "', _tokenId,'", "name": "', name,'", "timestamp": "', now,'"}',
                        '}'
                    )
                )
            )
        );
    }
}
