// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // Import the ERC20 interface

import "@openzeppelin/contracts/security/ReentrancyGuard.sol"; //Import Reentract gurad

import "@openzeppelin/contracts/Utils/math/SafeMath.sol"; // Import the SafeMath library for gas fee optimization



contract TokenConverter is ReentrancyGuard{

    address public owner;
    IERC20 public token1; // Address of Token 1
    IERC20 public token2; // Address of Token 2
    uint public conversionFee; // Fee amount in Token 1


    using SafeMath for uint; // Use SafeMath for arithmetic operations

    mapping(address => uint) public userBalances; // Mapping to track user balances

    // Define a struct to represent a conversion
    struct Conversion {
    address user;        // User's address
    uint amount;     // Amount of Token 1 converted
    uint converted;  // Amount of Token 2 received
    uint fee;        // Conversion fee in Token 1
    }

    //modifier to ensure the user has a minimum balance
    modifier hasMinimumBalance(uint minimumBalance) {
    require(userBalances[msg.sender] >= minimumBalance, "Insufficient balance");
    _; // Continue with the function if the condition is met
    }

    //modifier for functions that only the owner will have authority to call
    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can call this function!");
        _;  // Continue with the function if the condition is met
    }


    // Create an array to store conversion records
    Conversion[] public conversionHistory;



    //Events
    event ConversionEvent(
        address indexed user,
        uint amount,
        uint converted,
        uint fee
    );
    
    //constructor
    constructor(address _token1, address _token2, uint _conversionFee) {
        owner = msg.sender;
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
        conversionFee = _conversionFee;
    }
    
    // Function to convert Token 1 to Token 2 with a fee
    function convertToken(uint amount) public{
        // Ensure the input amount is greater than zero
        require(amount > 0, "Amount must be greater than zero");
        
        // Transfer the input amount of Token 1 from the user to this contract
        require(token1.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        
        // Calculate the conversion rate (for example purposes)
        uint conversionRate = 2; // 1 Token 1 = 2 Token 2
        
        // Calculate the converted amount of Token 2 using SafeMath
        uint256 convertedAmount = amount.mul(conversionRate);
        
        // Transfer the converted amount of Token 2 to the user
        require(token2.transfer(msg.sender, convertedAmount), "Transfer failed");
        
        // Calculate and deduct the conversion fee from the user using SafeMath
        uint256 feeAmount = amount.mul(conversionRate).mul(conversionFee).div(100); // Calculate the fee

        require(token1.transfer(owner, feeAmount), "Fee transfer failed");


      // Update the user's balance in the mapping
      userBalances[msg.sender] = userBalances[msg.sender].add(amount);


      // Create a new Conversion instance
        Conversion memory newConversion = Conversion({
            user: msg.sender,
            amount: amount,
            converted: convertedAmount,
            fee: feeAmount
        });

        // Add the new conversion record to the history
        conversionHistory.push(newConversion);

        emit ConversionEvent(msg.sender, amount, convertedAmount, feeAmount);
    }

    // Function to get the number of conversions
    function getConversionCount() public view returns (uint) {
        uint count = conversionHistory.length;

        // To ensure count is non-negative (should always be true)
        assert(count >= 0);

        return count;    
    }

    // Function to get conversion details by index
    function getConversionDetails(uint256 index) public view returns (address, uint, uint, uint) {
        require(index < conversionHistory.length, "Invalid index");
        Conversion memory conversion = conversionHistory[index];
        return (conversion.user, conversion.amount, conversion.converted, conversion.fee);
    }

    function changeOwnerName(address newOwner) public onlyOwner {
        owner = newOwner;
    } 

}


