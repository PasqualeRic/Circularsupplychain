pragma solidity >=0.7.0 <0.9.0;
import "./Manufacturer.sol";
import "./Shop.sol";
import "./Transport.sol";
import "hardhat/console.sol";
contract DEMO{
    Manufacturer public manufacturer;
    Shop public shop;
    Shop public shop2;
    Transport public transport;
    constructor() public{
        manufacturer = new Manufacturer("Gucci");
        shop = new Shop("shop1", "Gucci", 100, 200, 300);
        shop2 = new Shop("shop2", "Gucci", 100, 200, 300);
        transport = new Transport("Bartolini");
    }
    function ordine() public returns(bool){
       uint codiceConsegna = shop.createOrder(manufacturer.contractAddress(),transport.contractAddress(),1,1,1);
       bool controllo = shop.controlloOrdine(transport.contractAddress(), codiceConsegna);

       return controllo;
    }
}