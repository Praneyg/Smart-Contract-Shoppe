// SPDX-License-Identifier: MIT

// Only allow compiler versions from 0.7.0 to (not including) 0.9.0
pragma solidity >=0.7.0 <0.9.0;

contract ShoesStore {

    // State variables
    address public owner; // Owner
    bool storeIsOpen; //Check if store is open

    //nike shoes 
    mapping (address => uint) airforceStock;
    mapping (address => uint) airjordanStock;
    mapping (address => uint) dunksStock;
    mapping (address => uint) airmaxStock;

    //adidas shoes 
    mapping (address => uint) ultraboostStock;
    mapping (address => uint) racerStock;
    mapping (address => uint) fluidflowStock;
    
    // On creation...
    constructor () {
        // Set the owner as the contract's deployer
        owner = msg.sender;

        // Set initial shoes stocks
        airforceStock[address(this)] = 100;
        airjordanStock[address(this)] = 150;
        dunksStock[address(this)] = 300;
        airmaxStock[address(this)] = 450;
        ultraboostStock[address(this)] = 250;
        racerStock[address(this)] = 300;
        fluidflowStock[address(this)] = 500;

        // The store is initially opened
        storeIsOpen = true;
    }

    // Function to compare two strings
    function compareStrings(string memory a, string memory b) private pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked(b)));
    }

    // Let the owner restock the store
    function restock(uint amount, string memory shoesType) public {
        // Only the owner can restock!
        require(msg.sender == owner, "Only the owner can restock the machine!");

        // Refill the stock based on the type passed in
        if (compareStrings(shoesType, "airforce")) {
            airforceStock[address(this)] += amount;
        } else if (compareStrings(shoesType, "airjordan")) {
            airjordanStock[address(this)] += amount;
        } else if (compareStrings(shoesType, "dunks")) {
            dunksStock[address(this)] += amount;
        } else if (compareStrings(shoesType, "airmax")) {
            airmaxStock[address(this)] += amount;
        } else if (compareStrings(shoesType, "ultraboost")) {
            ultraboostStock[address(this)] += amount;
        } else if (compareStrings(shoesType, "racer")) {
            racerStock[address(this)] += amount;
        } else if (compareStrings(shoesType, "fluidflow")) {
            fluidflowStock[address(this)] += amount;
        } else if (compareStrings(shoesType, "all")) {
            airforceStock[address(this)] += amount;
            airjordanStock[address(this)] += amount;
            dunksStock[address(this)] += amount;
            airmaxStock[address(this)] += amount;
            ultraboostStock[address(this)] += amount;
            racerStock[address(this)] += amount;
            fluidflowStock[address(this)] += amount;
        }
    }

    // Let the owner open and close the store
    function openOrCloseStore() public returns (string memory) {
        if (storeIsOpen) {
            storeIsOpen = false;
            return "Store is now closed.";
        } else {
            storeIsOpen = true;
            return "Store is now open.";
        }
    }

    // Purchase a shoes from the store
    function purchase(uint amount, string memory shoesType) public payable {
        require(storeIsOpen == true, "The store is closed and you may not buy shoes.");
        require(msg.value >= amount * 2 ether, "You must pay at least 2 ETH per shoes!");

        // Sell a shoes based on type asked
        if (compareStrings(shoesType, "airforce")) {
            airforceStock[address(this)] -= amount;
            airforceStock[msg.sender] += amount;
        } else if (compareStrings(shoesType, "airjordan")) {
            airjordanStock[address(this)] -= amount;
            airjordanStock[msg.sender] += amount;
        } else if (compareStrings(shoesType, "dunks")) {
            dunksStock[address(this)] -= amount;
            dunksStock[msg.sender] += amount;
        } else if (compareStrings(shoesType, "airmax")) {
            airmaxStock[address(this)] -= amount;
            airmaxStock[msg.sender] += amount;
        } else if (compareStrings(shoesType, "ultraboost")) {
            ultraboostStock[address(this)] -= amount;
            ultraboostStock[msg.sender] += amount;
        } else if (compareStrings(shoesType, "racer")) {
            racerStock[address(this)] -= amount;
            racerStock[msg.sender] += amount;
        } else if (compareStrings(shoesType, "fluidflow")) {
            fluidflowStock[address(this)] -= amount;
            fluidflowStock[msg.sender] += amount;
        }
    }

    // Get stock of a specific type of shoes
    function getStock(string memory shoesType) public view returns (uint) {
        // Get stock of a shoes based on the type passed in
        if (compareStrings(shoesType, "airforce")) {
            return airforceStock[address(this)];
        } else if (compareStrings(shoesType, "airjordan")) {
            return airjordanStock[address(this)];
        } else if (compareStrings(shoesType, "dunks")) {
            return dunksStock[address(this)];
        } else if (compareStrings(shoesType, "airmax")) {
            return airmaxStock[address(this)];
        } else if (compareStrings(shoesType, "ultraboost")) {
            return ultraboostStock[address(this)];
        } else if (compareStrings(shoesType, "racer")) {
            return racerStock[address(this)];
        } else if (compareStrings(shoesType, "fluidflow")) {
            return fluidflowStock[address(this)];
        } else {
            return 0;
        }
    }
}
