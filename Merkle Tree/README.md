# Merkle Airdrop Smart Contract

This smart contract implements a Merkle Tree-based airdrop, allowing eligible users to claim their airdrop securely and efficiently.

## How It Works
1. The contract is deployed with a **Merkle Root** generated off-chain.
2. Users submit a **Merkle Proof** to verify their eligibility.
3. If the proof is valid and the user hasn’t claimed yet, they can claim the airdrop.

## Features
- Uses **Merkle Proofs** for verification.
- Prevents duplicate claims using a **mapping**.
- Secure and gas-efficient airdrop mechanism.

## Usage
1. Deploy the contract with a **Merkle Root**.
2. Call `claimAirdrop(bytes32[] calldata merkleProof)` with a valid proof.
3. If valid, the claim is recorded, and the user receives the airdrop.

## Dependencies
- OpenZeppelin’s `MerkleProof` library.

## Example Merkle Proof Generation
Merkle Trees and proofs must be computed **off-chain**. You can use:
- `merkletreejs` (for JavaScript)
- OpenZeppelin’s Merkle utilities

## License
This project is licensed under the **MIT License**.
