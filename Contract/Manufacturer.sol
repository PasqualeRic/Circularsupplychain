pragma solidity >=0.7.0 <0.9.0;
import "hardhat/console.sol";
import "./Transport.sol";
import "./Shop.sol";
contract Manufacturer{
    string nomeAzienda;
    uint nBorse;
    uint nCinture;
    uint nPortafogli;
    uint consumo;
    string mezzo;
    constructor(string memory _nomeAzienda) public{
        nomeAzienda = _nomeAzienda;
    }
    //funzione che restituisce l'indirizzo del contratto
    function contractAddress() public view returns (address) {
        return address(this);
    }
    //funzione che processa l'ordine e manda sia al negozio che al corriere un codice di consegna 
    function processOrder(address _shop, address _transport, uint _numeroBorse, uint _numeroCinture, uint _numeroPortafogli) public returns(uint){
        Transport transport = Transport(_transport);
        nBorse = _numeroBorse;
        nCinture = _numeroCinture;
        nPortafogli = _numeroPortafogli;
        uint codiceConsegna = uint(keccak256(abi.encodePacked(_shop)));
        transport.inConsegna(codiceConsegna, _shop);
        return codiceConsegna;
    }
    //funzione che chiede al corriere di calcolare il consumo per ogni mezzo e restituirmi il mezzo migliore con il consumo
    function calcoloConsumo(address _shop, address _transport) public returns(string memory, uint){
        uint distanzaAerea;
        uint distanzaAsfalto;
        uint distanzaRotaie;
        Transport transport = Transport(_transport);
        Shop shop = Shop(_shop);
        (distanzaAerea, distanzaAsfalto, distanzaRotaie) = shop.getDistance();
        (mezzo,consumo) = transport.calcoloConsumo(distanzaAerea, distanzaAsfalto, distanzaRotaie);
        return(mezzo, consumo);
    }
}


/*contract Transport{
    uint w;
    uint h;
    uint n1;
    uint n2;
    uint n3;
    bool matassaOK;
    struct Rettangoli{
        uint w;
        uint h;
    }
    Rettangoli[] rettangoli;

    mapping(uint => mapping(uint => bool)) statoMatassa;
    constructor(uint _w, uint _h, uint _n1, uint _n2, uint _n3) public {
        w = _w;
        h = _h;
        n1 = _n1;
        n2 = _n2;
        n3 = _n3;
        matassaOK = true;
    }
    function inizializzazione() public returns(bool){
        //Inizializzo la matrice a false
        for(uint i=0; i<uint(h); i++){
            for(uint j=0; j<w; j++){
                statoMatassa[i][j] = false;
            }
	    }

	  //inizializzo l'array dei rettangoli da controllare
        for(uint i = 0; i < n1; i++){
            Rettangoli memory r;
            r.w = 1;
            r.h = 2;
            rettangoli.push(r);
        }

        for(uint i = 0; i < n2; i++){
            Rettangoli memory r;
            r.w = 1;
            r.h = 2;
            rettangoli.push(r);
        }

        for(uint i = 0; i < n3; i++){
            Rettangoli memory r;
            r.w = 1;
            r.h = 3;
            rettangoli.push(r);
        }
        //da qua 
       for(uint z=0;z<uint(rettangoli.length);z++){
            bool rettangoloAllocato = false;
            for(uint wi=0; wi<w && !rettangoloAllocato; wi++){
                 for(uint hi=h-1; hi>=0 && !rettangoloAllocato; hi--){
                     if((wi+rettangoli[z].w) <=w){
                         int val = int(hi+1);
                         int p = int(rettangoli[z].h);
                         if(val-p >= 0){
                            if(check(rettangoli[z],wi,hi))
                            {
                                rettangoloAllocato = true;
                            }
                         }
                     }
                     if(hi == 0)
                    {
                         break;
                    }
                 }
            }
            if(rettangoloAllocato == false){
                matassaOK = false;
                break;
            }
        }
	
    if (matassaOK == true) {
        return true;
    } else {
        return false;
    }

    //a qua sistemare
    }
    function check(Rettangoli memory rettangoli, uint w0, uint h0) public returns(bool){
        for(uint i=w0;i<w0+rettangoli.w;i++){
            for(uint j=uint(h0);j>=uint(h0+1-rettangoli.h);j--){
                if(statoMatassa[j][i])		// mi basta trovare una cella occupata che restituisco false
                    return false;
                if(j==0)
                    break;
            }
	}
	
	// se sono arrivato qui vuol dire che nessuna della celle che mi servono sono occpuate.
	// aggiorno lo stato della matassa indicando quali celle occupo e poi ritorno true
	
	for(uint i=w0;i<w0+rettangoli.w;i++){
		for(uint j=uint(h0);j>=uint(h0+1-rettangoli.h);j--){
			statoMatassa[j][i] = true;
            if(j==0)
                break;
		}
	}
	
	return true;
    }

   function stampa() public returns(bool[5][4] memory){
        bool[5][4] memory m;
        for(uint i=0; i<h; i++){
            for(uint j=0; j<w; j++){
                statoMatassa[i][j] = false;
            }
	    }
        for(uint i = 0; i < 5; i++){
            for(uint j = 0; j < 4; j++){
                m[j][i] = statoMatassa[i][j];
            }
        }
        m[0][4] = true;
        return m;
    }
}
*/


/*contract Manufacturer{
    struct Rettangoli {
    uint w;
    uint h;
  }
  Rettangoli[] rettangoli;
  event LogTrue(uint);
  bool[5][4] statoMatassa;
  uint w;
  uint h;
  uint n1;
  uint n2;
  uint n3;
  bool matassaOK;

    constructor(uint _w, uint _h, uint _n1, uint _n2, uint _n3) public {
        w = _w;
        h = _h;
        n1 = _n1;
        n2 = _n2;
        n3 = _n3;
        matassaOK = true;
    }
    function inizializzazione() public returns(bool){
        for(uint i=0; i<w; i++){
            for(uint j=0; j<h; j++){
                statoMatassa[j][i] = false;
            }
	    }

        for(uint i = 0; i < n1; i++){
            Rettangoli memory r;
            r.w = 1;
            r.h = 2;
            rettangoli.push(r);
        }

        for(uint i = 0; i < n2; i++){
            Rettangoli memory r;
            r.w = 1;
            r.h = 2;
            rettangoli.push(r);
        }

        for(uint i = 0; i < n3; i++){
            Rettangoli memory r;
            r.w = 1;
            r.h = 3;
            rettangoli.push(r);
        }
    emit LogTrue(statoMatassa[0].length);
    for (uint z = 0; z < rettangoli.length; z++) {
      Rettangoli memory rettangolo = rettangoli[z];
      bool rettangoloAllocato = false;
      for (uint wi = 0; wi < statoMatassa[0].length && !rettangoloAllocato; wi++) {
        for (uint hi = statoMatassa.length - 1; hi >= 0 && !rettangoloAllocato; hi--) {
            int val = int(hi+1);
            int p = int(rettangolo.h);
          if (((wi + rettangolo.w) <= statoMatassa[0].length) && (val-p >= 0) && check(rettangolo, wi, hi)) {
            rettangoloAllocato = true;
          }
          if(hi==0)
          {
              break;
          }
        }
        if(!rettangoloAllocato)
        {
            matassaOK = false;
            break;
        }
      }
    }
    if (matassaOK == true) {
        return true;
    } else {
        return false;
    }
  }
  function check(Rettangoli memory rettangolo, uint w0, uint h0) public returns (bool) {
        for(uint i=w0;i<w0+rettangolo.w;i++){
            for(uint j=h0;j>=h0+1-rettangolo.h;j--){
                if(statoMatassa[j][i])
                {
                    return false;   
                }
                if(j==0)
                {
                    break;
                }
            }
        }

        for(uint i=w0;i<w0+rettangolo.w;i++){
            for(uint j=h0;j>=h0+1-rettangolo.h;j--){
                statoMatassa[j][i] = true;
                 if(j==0)
                {
                    break;
                }
            }
        }

        return true;
    }
}*/