// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';
import '@openzeppelin/contracts/utils/Counters.sol';
import 'hardhat/console.sol';

contract MyNFT is ERC721URIStorage {
    
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721('SquareNFT', 'SQUARE') {
        console.log('My first nft contract @juansevillano');
    }

    function makeAnNFT() public {
        // Getting current token id
        uint256 newItemId = _tokenIds.current();

        // Mint nft using msg.sender
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, 'https://jsonkeeper.com/b/RQN8');

        console.log(
            'An NFT w/ ID %s has been minted to %s',
            newItemId,
            msg.sender
        );

        // increment counter for next id minted
        _tokenIds.increment();
    }
}
