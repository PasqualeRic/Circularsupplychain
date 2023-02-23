pragma solidity >=0.7.0 <0.9.0;
import "./Manufacturer.sol";
import "./Template.sol";
contract Oracle is Template{
    address public owner;
    Manufacturer public manufacturer;
    uint valore;
    uint prova;
    Coordinate[] coordinate;
    constructor(){
        owner = msg.sender;
    }
    event calcolo_consumo(Matasse[] matasse, uint numeroBorse, uint numeroCinture, uint numeroPortafogli);

    function callOracle(uint _numeroBorse, uint _numeroCinture, uint _numeroPortafogli, address _manufacturer) external { 
        manufacturer = Manufacturer(_manufacturer);
        Matasse[] memory matasse = manufacturer.returnMatasse();
        emit calcolo_consumo(matasse, _numeroBorse, _numeroCinture, _numeroPortafogli);
    }
    function returnConsumo(uint _valore, uint _m1, uint _m2, uint _m3) external{
        manufacturer.setValue(_valore,_m1,_m2,_m3);
    }
    function setCoordinate(uint x0, uint y0, uint xw, uint yh) external{
        coordinate.push(Coordinate(x0,y0,xw,yh));
    }
    function returnCoordinate() external returns(Coordinate[] memory){
        return coordinate;
    }
    //azzera la struct delle coordinate dopo ogni esecuzione
    function elimina(uint l)public {
        delete(coordinate);
    }
}