pragma solidity 0.4.25;

contract Roles {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not an owner.");
        _;
    }

    modifier onlyUser {
        require(msg.sender != owner, "Not a user.");

        address sender = msg.sender;
        uint size;
        assembly { size := extcodesize(sender) }

        require(size == 0, "Not a user.");
        _;
    }
}