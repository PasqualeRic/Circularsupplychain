pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
contract Transport{
    string nomeCorriere;
    mapping(address => uint) listaConsegne;
    constructor(string memory _nomeCorriere) public{
        nomeCorriere = _nomeCorriere;
    }
    //funzione che restituisce l'indirizzo del contratto
    function contractAddress() public view returns (address) {
        return address(this);
    }
    function inConsegna(uint codiceConsegna, address _shop) public{
        listaConsegne[_shop] = codiceConsegna;
    }
    function controllo(address _shop, uint codiceConsegna) public returns(bool){
        if(listaConsegne[_shop] == codiceConsegna){
            return true;
        }else{
            return false;
        }
    }
}