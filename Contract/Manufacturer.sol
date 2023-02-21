pragma solidity >=0.7.0 <0.9.0;
import "./Transport.sol";
import "./Shop.sol";
import "./Oracle.sol";
contract Manufacturer{
    Oracle public oracle; 
    string nomeAzienda;
    uint nBorse;
    uint nCinture;
    uint nPortafogli;
    uint consumo;
    string mezzo;
    uint spreco;
    uint matassa1;
    uint matassa2;
    uint matassa3;
    uint prova;
    struct Matasse{
        uint w;
        uint h;
    }
    Matasse[] matasse;

     struct Coordinate{
        uint X0;
        uint Y0;
        uint Xw;
        uint Yh;
    }
    Coordinate[] coordinate1;
    constructor(string memory _nomeAzienda) public{
        matasse.push(Matasse(2000,100));
        matasse.push(Matasse(4000,100));
        matasse.push(Matasse(6000,100));
        //imposto il nome dell'azienda
        nomeAzienda = _nomeAzienda;
    }

    //funzione che restituisce l'indirizzo del contratto
    function contractAddress() public view returns (address) {
        return address(this);
    }
    //funzione che processa l'ordine e manda sia al negozio che al corriere un codice di consegna 
    function processaOrdine(address _shop, address _transport, uint _numeroBorse, uint _numeroCinture, uint _numeroPortafogli) external returns(uint){
        Transport transport = Transport(_transport);
        nBorse = _numeroBorse;
        nCinture = _numeroCinture;
        nPortafogli = _numeroPortafogli;
        uint codiceConsegna = uint(keccak256(abi.encodePacked(_shop)));
        transport.inConsegna(codiceConsegna, _shop);
        return codiceConsegna;
    }
    //funzione che chiede al corriere di calcolare il consumo per ogni mezzo e restituirmi il mezzo migliore con il rispettivo consumo
    function calcoloConsumo(address _shop, address _transport) external{
        uint distanzaAerea;
        uint distanzaAsfalto;
        uint distanzaRotaie;
        Transport transport = Transport(_transport);
        Shop shop = Shop(_shop);
        (distanzaAerea, distanzaAsfalto, distanzaRotaie) = shop.getDistance();
        (mezzo,consumo) = transport.calcoloConsumo(distanzaAerea, distanzaAsfalto, distanzaRotaie);
    }
    //funzione che calcola il tessuto sprecato durante il taglio tramite un oracolo
    function calcoloSpreco(address _oracleAddress) external{
        oracle = Oracle(_oracleAddress);
        oracle.callOracle(nBorse, nCinture, nPortafogli, address(this));
    }
    //funzione che riceve la quantià di spreco dall'oracolo
    function setValue(uint val, uint _m1, uint _m2, uint _m3) external{
        matassa1 = _m1;
        matassa2 = _m2;
        matassa3 = _m3;
        spreco = val;
    }
    function retP() external returns(Oracle.Coordinate[] memory){
        Oracle.Coordinate[] memory coordinate = oracle.returnCoordinate();
        return coordinate;
    }
    function returnConsumo() external returns(uint){
        return(consumo);
    }
    function returnMezzo() external returns(string memory){
        return(mezzo);
    }
    function returnMatasse() external returns(Matasse[] memory){
        return matasse;
    }
    function returnValue() external returns(uint){
        return spreco;
    }
    function returnNumeroMatassa1() external returns(uint){
        return matassa1;
    }
    function returnNumeroMatassa2() external returns(uint){
        return matassa2;
    }
    function returnNumeroMatassa3() external returns(uint){
        return matassa3;
    }
}

