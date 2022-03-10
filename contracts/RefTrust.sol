// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract MtgTradingReference {
    
    uint256 private reference_counter;
    address private creator;
    uint256 private globalReferenceCounter;
    
    constructor() {
        // Should be me
        creator = msg.sender;
        globalReferenceCounter = 0;
    }
    

    struct Trader {
        address trader_address;
        string trader_name; // has to be unique
        uint256 trader_reference_count;
        uint index;
        bool isblocked;
    }
    
    /*
    Dies sind nun die drei Hauptkomponenten der "Datenbank". Eine List aller Addressen mit dem jeweiligen Index, die Instanziierung des Traders
    und dann die Speicherung der Structs in einem Mapping! 
    */
    
    address[] private traderIndex;
    // Initialise the User Object
    Trader aTrader;
    


    /* 
    # Create the connection between the address and the Object
    # At the same time, don't make it public, rather make the mapping private, so that no other contract can 
    accidentally overwrite it. It has to be stable.
    */
    mapping(address => Trader) private traderStructs;
    // referenceGiven[toaddress] = addressofGivingPerson
    mapping(address => address) private referenceGiven;
    mapping(address => address) private referenceTaken;
    // MAPPING OF A Reference Giver and a Reference Taker!!!


    /*
    #################### LOGS ####################
    */

    event LogNewReference (
        address indexed referenceGiverAddress,
        address indexed referenceTakerAddress,
        string referenceMessage
    );

    event LogNewTrader (
        address indexed newTraderAddress        
    );
    

    function addTrader(string memory _traderName) public returns(uint index){
        
        address _traderAddress = msg.sender;
        require(isUser(msg.sender)!=true);


        traderStructs[_traderAddress].isblocked = false;
        traderStructs[_traderAddress].trader_name = _traderName;
        traderStructs[_traderAddress].trader_reference_count = 0;
        traderStructs[_traderAddress].index = traderIndex.length;
        // I did not get this. Why is that good? How do we save space?
        // traderStructs[_traderAddress].index = traderIndex.push(_traderAddress)-1;
        traderIndex.push(_traderAddress);
        emit LogNewTrader(
            _traderAddress
        );
        return traderIndex.length-1;
    }
    

    function getTrader(address traderAddress) public view returns (string memory trader_name, uint256 trader_reference_count, uint index){
        // Das könnte ich offen lassen, falls Leute schauen wollen, ob derjenige ein Nutzer ist.
        require(isUser(msg.sender)==true);
        return(traderStructs[traderAddress].trader_name, 
                traderStructs[traderAddress].trader_reference_count,
                traderStructs[traderAddress].index);
                
    }


    function addReference(address traderAddress, string memory message) public returns(bool success) {
        // Todo: Add the functionality that a user cannot get a reference when he/she isblocked
        require(isUser(msg.sender)==true);
        require(isUser(traderAddress)==true);
        require(hasNotReferenced(traderAddress)==true);
        

        // Increment the count by one
        traderStructs[traderAddress].trader_reference_count++;
        globalReferenceCounter++;
        // Mapping the Reference Giver with the Reference Taker. 
        referenceGiven[traderAddress] = msg.sender;

        // Reference Type (other Products/Goods/Services, Needed?)
        // Username in Facebook? Any other Social Network?
        // Reference Product ()

        // Reference Value???

        // Event Log 
        emit LogNewReference(
            msg.sender,
            traderAddress,
            message
        );

        return true;
    }

    function hasNotReferenced(address traderAddress) public view returns(bool referenced){
        if(referenceGiven[traderAddress]==msg.sender) return false;
        // Should be true
        return (referenceGiven[traderAddress]!=msg.sender);
    }



    function isUser(address traderAddress) public view returns(bool isIndeed){
        // Wenn der Index nicht vorhanden ist, dann existiert der Nutzer nicht
        if(traderIndex.length == 0) return false;
        // true 
        return (traderIndex[traderStructs[traderAddress].index]==traderAddress);
    }

    // We expose the record count so people can test with this
    function getUserCount() public view returns(uint count){
        return traderIndex.length;
    }

    function getUserAtIndex(uint index) public view returns(address traderAddress) {
        return traderIndex[index];
    }


}

