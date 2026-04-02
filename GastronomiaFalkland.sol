// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaFalkland
 * @dev Registro historico con Likes, Dislikes e Identificador de Origen Ovino (Mutton).
 * Nota: Se evita el uso de caracteres especiales para maxima compatibilidad.
 */
contract GastronomiaFalkland {

    struct Plato {
        string nombre;
        string descripcion;
        string tipoLana; // Referencia a la calidad/raza del ganado: Ej: Merino, Corriedale, Polwarth
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con el Mutton Pie
        registrarPlato(
            "Mutton Pie", 
            "Pastel de masa quebrada relleno de trozos de cordero adulto cocinado lentamente.",
            "Corriedale"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _tipoLana
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            tipoLana: _tipoLana,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory tipoLana,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.tipoLana, p.likes, p.dislikes);
    }
}
