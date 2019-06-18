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
        require(age >= 1 && age <= 115, "Wrong age value.");
        _;
    }
    
    function writeNewUser(
        string name,
        string surname,
        uint8 age) external ageInRange(age) returns (bool) {
            
        UserData memory newUser = UserData(
			name,
			surname,
			age,
			userAmount
		);
        userAmount += 1;
        users[msg.sender] = newUser;

        return true;
    }
    
    function getUserFirstName(address userAddress) public view returns(string) {
		return (users[userAddress].name);
	}

	function getUserLastName(address userAddress) public view returns(string) {
		return (users[userAddress].surname);
	}

	function getUserAge(address userAddress) public view returns(uint8) {
		return (users[userAddress].age);
	}

	function getUserId(address userAddress) public view returns(uint256) {
		return (users[userAddress].id);
	}

}