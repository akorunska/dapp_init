pragma solidity 0.4.24;

contract Passport {
    struct Person {
        string name;
        string surname;
        string countryCode;
        uint age;
        bool dataIsSet;
    }
    
    mapping (address => Person) registeredUsers;
    
    function registerNewUser(
        string _name,
        string _surname,
        string _countryCode,
        uint _age
        ) public {
            
        require(
            !registeredUsers[msg.sender].dataIsSet,
            "This user is already registered."
        );
        
        Person memory _person = Person({
            name: _name,
            surname: _surname,
            countryCode: _countryCode,
            age: _age,
            dataIsSet: true
        });

        registeredUsers[msg.sender] = _person;
    }

    function isRegisteredUser(address _addr) public view returns (bool) {
        return registeredUsers[_addr].dataIsSet;
    }
    
    function getUserData(address _addr) 
        public 
        view 
        returns(string, string, string, uint) 
    {
        Person memory _person = registeredUsers[_addr];
        return (_person.name, _person.surname, _person.countryCode, _person.age);
    }
}


// mock user data

// "name", "surname", "ua", 18
// "alla", "white", "ua", 30 
// "petya", "kekeke", "ru", 26 
// "john", "smith", "en", 20 
// "helen", "marlen", "pl", 65
