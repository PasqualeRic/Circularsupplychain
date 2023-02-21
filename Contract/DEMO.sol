pragma solidity >=0.7.0 <0.9.0;
import "./Manufacturer.sol";
import "./Shop.sol";
import "./Transport.sol";
import "hardhat/console.sol";
contract DEMO{
    Manufacturer public manufacturer;
    Oracle public oracle; 
    Shop public shop;
    Shop public shop2;
    Transport public transport;
    uint consumo;
    string mezzo;
    constructor() public{
        manufacturer = new Manufacturer("Gucci");
        shop = new Shop("shop1", "Gucci", 10, 200, 4000);
        shop2 = new Shop("shop2", "Gucci", 100, 200, 300);
        transport = new Transport("Bartolini");
        oracle = new Oracle();
    }

    function ordine() public returns(string memory, uint){
       shop.creaOrdine(manufacturer.contractAddress(),transport.contractAddress(),1,1,1);
       uint codiceConsegna = shop.returnCodiceOrdine();
       shop.controlloOrdine(transport.contractAddress(), codiceConsegna);
       bool controllo = shop.returnControlloOrdine();
       require(controllo == true, "il codice e' errato o il pacco non e' corretto");
       manufacturer.calcoloConsumo(shop.contractAddress(), transport.contractAddress());
       mezzo = manufacturer.returnMezzo();
       consumo = manufacturer.returnConsumo();
       return ( mezzo, consumo);
    }
}