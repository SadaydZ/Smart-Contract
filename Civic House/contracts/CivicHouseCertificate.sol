// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract CivicHouseCertificate is ERC721 {
    address public owner;
    uint256 public nextTokenId;
    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC721("CivicHouseCertificate", "CHC") {
        owner = msg.sender; // Establecer el creador como propietario
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "No eres el propietario");
        _;
    }

    // Función para emitir un nuevo certificado
    function mintCertificate(address to, string memory uri) public onlyOwner {
        uint256 tokenId = nextTokenId;
        nextTokenId++;
        _mint(to, tokenId); // Emitir el NFT
        _setTokenURI(tokenId, uri); // Establecer la URI del token
    }

    // Función interna para establecer la URI del token
    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        _tokenURIs[tokenId] = uri;
    }

    // Función para obtener la URI del token, ahora con "override"
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return _tokenURIs[tokenId];
    }
}