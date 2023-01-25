pragma solidity >=0.7.0 <0.9.0;

contract Supplier{
    string name;
    string material;
    uint quantity;
    uint price;
    // supponiamo che il materiale utilizzato sia sempre pelle e la quantità ci verrà fornita una volta
    //calcolati i consumi con rotoli da 20, 40 o 60 metri
    constructor(string memory name, uint quantity, uint price) public{
        name = name;
        material = 'Leather';
        quantity = quantity;
        price = price;
    }
}