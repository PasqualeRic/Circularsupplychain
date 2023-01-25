pragma solidity >=0.7.0 <0.9.0;
contract Shop{
    string private id;
    string private country;
    string private city;
    string private streetAddress;
    string private cap;
    string private name;
    string private province;
    constructor (string memory id, string memory shopName, string memory streetAddress, string memory cap, string memory city, string memory province, string memory country) public payable{
        id = id;
        country = country;
        city = city;
        streetAddress = streetAddress;
        cap = cap;
        shopName = shopName;
        province = province;
    }

    //funzione che permettere al negozio di fare ordini all'azienda
    
}