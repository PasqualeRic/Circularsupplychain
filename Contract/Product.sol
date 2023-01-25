pragma solidity >=0.7.0 <0.9.0;

contract Product{
    string material;
    string nameProduct;
    string public price;
    constructor(string memory _material, string memory _nameProduct, string memory _price) public{
        material = _material;
        nameProduct = _nameProduct;
        price = _price;
    }
}