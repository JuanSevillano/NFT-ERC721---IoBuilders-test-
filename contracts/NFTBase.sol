// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTCollection is IERC1155, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string private ipfs =
        "https://ipfs.filebase.io/ipfs/Qmc5pDm3zNxr8aGxiyhUVPxVCRh5a94Qv1FSJCrCT46akr";

    event NewNFTMinted(address sender, uint256 tokenId);

    constructor() IERC1155(ipfs) {
        console.log("My second nft contract @juansevillano");
    }

    function makeAnNFT() public {
        // Getting current token id
        uint256 newItemId = _tokenIds.current();

        _mint(msg.sender, newItemId);
        _setUri(newItemId);

        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        _tokenIds.increment();

        emit NewNFTMinted(msg.sender, newItemId);
    }

    function mintBatch(address[] to)
        public
        onlyOwner
        returns (uint256[] memory tokenIds_)
    {
        tokenIds_ = new uint256[](to.length);
        for (uint256 i = 0; i < to.length; i++) {
            tokenIds_[i] = super.mint(to);
        }
    }

    function _checkArrayLengths(uint256 _array1Length, uint256 _array2Length)
        private
        pure
    {
        require(_array1Length == _array2Length, "Array length mismatch");
    }
}
