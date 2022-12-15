// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTCollection is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private _tokenIds;
    bool public revealed = false;
    string public baseURI =
        "https://ipfs.io/ipfs/QmUCCJrMChxUauZ5EsDNu1CkYCh6EU8Cx7XzcRExTEL9ip?filename=initial_metadata.json";

    string public scURI =
        "https://ipfs.io/ipfs/QmfE85vKZPsLwPvNbHozrTjGEURyVvQ9YLNucDxb9qSdqc?filename=blind_collection.json";

    event NewNFTMinted(address sender, uint256 tokenId);

    constructor() ERC721("De Geest van Gaston", "GVG") {}

    function publicMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIds.current();
        _safeMint(to, tokenId);
        _tokenIds.increment();
        emit NewNFTMinted(msg.sender, tokenId);
    }

    function airdrop(address[] calldata to) public onlyOwner {
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

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(super._exists(_tokenId), "token doesnt exist");
        string memory baseURI_ = _baseURI();

        if (!revealed) {
            return baseURI;
        }

        return
            bytes(baseURI_).length > 0
                ? string(
                    abi.encodePacked(
                        baseURI_,
                        Strings.toString(_tokenId),
                        ".json"
                    )
                )
                : "";
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function contractURI() public view returns (string memory) {
        return scURI;
    }

    function setContractURI(string memory contractURI_) public onlyOwner {
        scURI = contractURI_;
    }

    function reveal() public onlyOwner {
        revealed = true;
    }

    function setRevealURI(string memory baseURI_) public onlyOwner {
        require(revealed, "Collection not revealed");
        baseURI = baseURI_;
    }
}
