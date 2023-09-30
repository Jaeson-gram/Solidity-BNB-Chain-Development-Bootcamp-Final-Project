// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // Import the ERC20 interface

contract TokenConverter {

   address public owner;
    IERC20 public token1; // Address of Token 1
    IERC20 public token2; // Address of Token 2
    uint256 public conversionFee; // Fee amount in Token 1
    
    constructor(address _token1, address _token2, uint256 _conversionFee) {
        owner = msg.sender;
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
        conversionFee = _conversionFee;
    }
    
    function convertToken(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(token1.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        
        // Calculate the conversion rate (for example purposes)
        uint256 conversionRate = 2; // 1 Token 1 = 2 Token 2
        
        uint256 convertedAmount = amount * conversionRate;
        require(token2.transfer(msg.sender, convertedAmount), "Transfer failed");
        
        // Deduct the conversion fee from the user
        uint256 feeAmount = (amount * conversionRate * conversionFee) / 100; // Calculate the fee
        require(token1.transfer(owner, feeAmount), "Fee transfer failed");
    }
}
