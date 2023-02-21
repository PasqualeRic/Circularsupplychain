pragma solidity >=0.7.0 <0.9.0;
import "./Manufacturer.sol";
import "./Transport.sol";
contract Shop{
    string id;
    string shopName;
    uint distanzaAerea;
    uint distanzaAsfalto;
    uint distanzaRotaie;
    uint codiceConsegna;
    bool controllo;
    constructor (string memory _id, string memory _shopName, uint _distanzaAerea, uint _distanzaRotaie, uint _distanzaAsfalto) public{
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
    //funzione che invia all'azienda il numero di oggetti da produrre
    function creaOrdine(address _manufacturer, address _transport, uint numeroBorse, uint numeroCinte, uint numeroPortafogli) public{
        Manufacturer manufacturer = Manufacturer(_manufacturer);
        codiceConsegna = manufacturer.processaOrdine(address(this), _transport, numeroBorse, numeroCinte, numeroPortafogli); //l'azienda prende i dati e una volta in consegna l'ordine, restituisce un codice univoco 
    }
    function returnCodiceOrdine() public returns(uint){
        return codiceConsegna;
    }
    //funzione che permette al negozio di controllare che l'ordine consegnato sia effettivamente il suo
    function controlloOrdine(address _transport, uint codiceConsegna) public{
        Transport transport = Transport(_transport);
        controllo = transport.controllo(address(this), codiceConsegna);
    }
    function returnControlloOrdine() public returns(bool){
        return controllo;
    }
    //funzione che ritorna le distanze per ogni mezzo dall'azienda al negozio
    function getDistance() public returns(uint, uint, uint){
        return(distanzaAerea, distanzaAsfalto, distanzaRotaie);
    }
}