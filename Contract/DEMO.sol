pragma solidity >=0.7.0 <0.9.0;
import "./Manufacturer.sol";
import "./Product.sol";
// una semplice funzione che creato un prodotto tramite l'azienda mi restituisce il prezzo
contract DEMO{
    Manufacturer public manufacturer;
    Product public product;
    constructor() public{
        manufacturer = new Manufacturer("idManufacturer", "nameManufacturer", "");
    }
    function prova() public returns(string memory){
        string memory serial = manufacturer.createProduct("Pelle", "Borsa", "10");
        return serial;
    }
}