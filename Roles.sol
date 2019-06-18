pragma solidity 0.4.25;

/**
 * @title Roles
 * @dev The Roles contract has an owner and saleAgent address, and provides
 * basic authorization control functions, this simplifies the implementation
 * of "user permissions".
 */
contract Roles {
    address public owner;
    address public newOwner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modifier onlyUser {
        require(msg.sender != owner);

        address sender = msg.sender;
        uint size;
        assembly { size := extcodesize(sender) }

        require(size == 0);
        _;
    }

    function transferOwnership(address _newOwner) external onlyOwner {
        newOwner = _newOwner;
    }

    function acceptOwnership() external {
        require(msg.sender == newOwner);
        owner = newOwner;
        newOwner = address(0);
    }
}