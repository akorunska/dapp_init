pragma solidity 0.4.24;

import "./AccessRestricted";

contract Passport {
    struct Person {
        string name;
        string surname;
        string countryCode;
        uint age;
        uint userId;
    }
    
    Person[] public userData;
    mapping (address => bool) registeredUsers;
    
    function registerNewUser(
        string _name,
        string _surname,
        string _countryCode,
        uint _age, 
        uint _userId
        ) public {
            
        require(!registeredUsers[_userId]);
        
        Person storage _person = new Person(
            _name,
            _surname,
            _countryCode,
            _age,
            _userId);
        
        userData.push(_person);
        registeredUsers[_userId] = true;
    }
}
