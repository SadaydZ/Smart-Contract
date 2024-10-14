// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AnclapToken is ERC20 {
    address public admin;

    constructor() ERC20("AnclapToken", "ANCL") {
        admin = msg.sender; // Establecer al creador como administrador
        _mint(admin, 1000000 * (10 ** decimals())); // Emitir 1 millón de AnclapTokens al administrador
    }

    // Función para emitir más tokens, solo el administrador puede llamarla
    function mint(address to, uint256 amount) public {
        require(msg.sender == admin, "Solo el administrador puede emitir tokens");
        _mint(to, amount); // Emitir más tokens a la dirección especificada
    }

    // Función para transferir tokens entre usuarios, con una tarifa de transferencia
    function transferWithFee(address to, uint256 amount) public returns (bool) {
        uint256 fee = (amount * 1) / 100; // 1% de tarifa
        uint256 amountAfterFee = amount - fee;

        _transfer(msg.sender, to, amountAfterFee); // Transferir la cantidad menos la tarifa
        _transfer(msg.sender, admin, fee); // Transferir la tarifa al administrador
        return true;
    }
}