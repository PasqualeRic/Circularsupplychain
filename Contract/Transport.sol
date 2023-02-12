pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
contract Transport{
    string nomeCorriere;
    mapping(string => uint) consumoCamion;
    mapping(string => uint) consumiTotali;
    uint consumoAereo = 140;
    uint consumoTreno = 44; //consumo in grammi di CO2 per km percorso
    mapping(address => uint) listaConsegne;
    constructor(string memory _nomeCorriere) public{
        nomeCorriere = _nomeCorriere;
        consumoCamion["Diesel"] = 170;
        consumoCamion["Benzina"] = 190;
        consumoCamion["GPL"] = 100;
    }
    //funzione che restituisce l'indirizzo del contratto
    function contractAddress() public view returns (address) {
        return address(this);
    }
    //funzione che tiene traccia di tutti i codice di consegna che arrivano dall'azienda e vengono salvati in corrispondenza dell'indirizzo dello shop a cui devo mandare l'ordine
    function inConsegna(uint codiceConsegna, address _shop) public{
        listaConsegne[_shop] = codiceConsegna;
    }
    //funzione invocata dallo shop per controllare che il pacco sia effettivamente il suo
    function controllo(address _shop, uint codiceConsegna) public returns(bool){
        if(listaConsegne[_shop] == codiceConsegna){
            return true;
        }else{
            return false;
        }
    }
    //funzione che calcola il minor conusmo prodotto dai vari mezzi e restituisce quello migliore
    function calcoloConsumo(uint distanzaAerea, uint distanzaAsfalto, uint distanzaRotaie) public returns(string memory, uint){
        string[5] memory mezzi = ["Treno","Aereo", "CamionDiesel", "CamionBenzina", "CamionGPL"];
        
        consumiTotali["Treno"] = consumoTreno * distanzaRotaie;
        consumiTotali["Aereo"] = consumoAereo * distanzaAerea;
        consumiTotali["CamionDiesel"] = consumoCamion["Diesel"] * distanzaAsfalto;
        consumiTotali["CamionBenzina"] = consumoCamion["Benzina"] * distanzaAsfalto;
        consumiTotali["CamionGPL"] = consumoCamion["GPL"] * distanzaAsfalto;
        uint minValue = 0;
        string memory minKey;
        for(uint i = 0; i < 5; i++){
            string memory currentKey = mezzi[i];
            if (consumiTotali[currentKey] > 0 && (minValue == 0 || consumiTotali[currentKey] < minValue)) {
                minValue = consumiTotali[currentKey];
                minKey = currentKey;
            }
        }
        return(minKey, minValue);
    }
}