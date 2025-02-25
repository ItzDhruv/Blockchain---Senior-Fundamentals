// ✅ Secure Contract ✅
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract SecureContract is ReentrancyGuard {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external nonReentrant {
        require(balances[msg.sender] > 0, "No funds available");

        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0; // ✅ Update balance **before** sending funds

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }
}
