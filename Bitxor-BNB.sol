// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
/**
 * Contrato Inteligente Bitxor (BXR)
 *
 * Descripción: Este contrato define las funcionalidades y características de Bitxor (BXR), Bitxor Coin es la moneda nativa del blockchain Bitxor.
 * Los tokens de Bitxor se emiten y queman dinámicamente según la demanda y están disponibles para su compra, respetando el limite global.
 * Bitxor es compatible con los estándares ERC-20 y BEP-20, lo que garantiza su interoperabilidad en múltiples blockchains.
 *
 * Empresa: Bitxor Foundation
 * Sitio web: www.bitxor.org
 *
 * AVISO LEGAL: La empresa emisora de Bitxor, Bitxor Foundation., no se hace responsable por el uso indebido de esta criptomoneda ni por pérdidas financieras resultantes de su uso. Se recomienda a los usuarios realizar una investigación exhaustiva y consultar con profesionales financieros antes de adquirir Bitxor.
 */

pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.1/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@5.0.1/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts@5.0.1/access/Ownable.sol";
import "@openzeppelin/contracts@5.0.1/token/ERC20/extensions/ERC20Permit.sol";

/// @custom:security-contact admin@bitxor.org
contract Bitxor is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    uint256 private _maxSupply;

    constructor(
        address initialOwner,
        uint256 setMaxSupply
    ) ERC20("Bitxor", "BXR") Ownable(initialOwner) ERC20Permit("Bitxor") {
        _maxSupply = setMaxSupply * 10 ** decimals();
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(
            totalSupply() + amount <= _maxSupply,
            "Bitxor: La emision supera el suministro maximo"
        );
        _mint(to, amount);
    }

    function decimals() public view virtual override returns (uint8) {
        return 8;
    }

    function maxSupply() public view returns (uint256) {
        return _maxSupply;
    }
}
