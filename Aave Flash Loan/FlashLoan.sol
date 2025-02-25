// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol"; //Evm ni koi biji chain nu smart contract nu address lai skai 
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyFlashLoan is FlashLoanSimpleReceiverBase {
    address private owner;

    constructor(address _addressProvider) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider)) {
        owner = msg.sender;
    }

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        require(msg.sender == address(POOL), "Caller is not Aave Pool");

        // Example: Use funds (e.g., arbitrage, liquidation, etc.)
        // Implement your strategy here

        // Approve & repay loan + fees
        uint256 totalDebt = amount + premium;
        IERC20(asset).approve(address(POOL), totalDebt);

        return true;
    }

    function requestFlashLoan(address asset, uint256 amount) external {
        require(msg.sender == owner, "Not the owner");

        POOL.flashLoanSimple(
            address(this),  // Receiver
            asset,          // Token to borrow
            amount,         // Amount
            "",             // Extra data (if needed)
            0               // Referral code (optional)
        );
    }
}
