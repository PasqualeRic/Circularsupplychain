pragma solidity >=0.7.0 <0.9.0;
import "./Manufacturer.sol";
import "hardhat/console.sol";
contract Shop{
    string id;
    string shopName;
    uint distanzaAerea;
    uint distanzaAsfalto;
    uint distanzaRotaie;
    constructor (string memory _id, string memory _shopName, uint _distanzaAerea, uint _distanzaRotaie, uint _distanzaAsfalto) public payable{
        id = _id;
        shopName = _shopName;
        distanzaAerea = _distanzaAerea;
        distanzaAsfalto = _distanzaAsfalto;
        distanzaRotaie = _distanzaRotaie;
    }
    //funzione che restituisce l'indirizzo del contratto
    function contractAddress() public view returns (address) {
        return address(this);
    }
    
    function createOrder(address _manufacturer, address _transport, uint numeroBorse, uint numeroCinte, uint numeroPortafogli) public returns(uint){
        Manufacturer manufacturer = Manufacturer(_manufacturer);
        uint codiceConsegna = manufacturer.processOrder(address(this), _transport, numeroBorse, numeroCinte, numeroPortafogli);
        return codiceConsegna;
    }
    function controlloOrdine(address _transport, uint codiceConsegna) public returns(bool){
        Transport transport = Transport(_transport);
        bool controllo = transport.controllo(address(this), codiceConsegna);
        return controllo;
    }
}