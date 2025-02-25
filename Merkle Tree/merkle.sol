// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleAirdrop {
    bytes32 public merkleRoot;
    mapping(address => bool) public claimed;

    event AirdropClaimed(address indexed claimer);

    constructor(bytes32 _merkleRoot) {
        merkleRoot = _merkleRoot;
    }

    function claimAirdrop(bytes32[] calldata merkleProof) external {
        require(!claimed[msg.sender], "Airdrop already claimed");
        
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(merkleProof, merkleRoot, leaf), "Invalid proof");  // merkle proof use by openzepline library no need to implement 
        
        claimed[msg.sender] = true;
        emit AirdropClaimed(msg.sender);
    }
}
