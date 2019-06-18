pragma solidity 0.4.25;

import "./Roles.sol";

contract Passport is Roles {
    
    mapping(address => UserData) private users;   
    uint public userAmount;
    
    struct UserData {
        string name;
        string surname;
        uint8 age;
        uint id;
    }
    
    modifier ageInRange(uint8 age) {
        require(age >= 1 && age <= 115, "Wrong age value. 1 < age < 115.");
        _;
    }
    
    function writeNewUser(string name, string surname, uint8 age) external ageInRange(age) returns (bool) {
        
        uint id = userAmount;
        UserData memory newUser = UserData(
            name,
            surname,
            age,
            id
        );
        
        userAmount += 1;
        users[msg.sender] = newUser;
        return (true);
    }
    
    function userExist(address userAddress) external view returns(bool) {
        return (users[userAddress].id != 0);
    }

}