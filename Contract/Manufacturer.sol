pragma solidity >=0.7.0 <0.9.0;
import "./Product.sol";

contract Manufacturer{
    string private id;
    string private name;
    string private streetAddress;
  //  string private cap;
  //  string private city;
  //  string private province;
  //  string private country;
  //  uint public elementCounter;
    constructor( string memory _id, string memory _name, string memory _streetAddress){
        id = _id;
        name = _name;
        streetAddress = _streetAddress;
    }
    function createProduct(string memory _material, string memory _nameProduct, string memory _price) public returns(string memory){
        Product product = new Product(_material, _nameProduct, _price);
        return product.price();
    }    
}