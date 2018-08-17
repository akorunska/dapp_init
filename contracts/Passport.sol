pragma solidity 0.4.24;

contract Passport {
    struct Person {
        string name;
        string surname;
        string countryCode;
        uint age;
        address addr;
        bool dataIsSet;
    }
    
    mapping (address => Person) registeredUsers;
    
    function registerNewUser(
        string _name,
        string _surname,
        string _countryCode,
        uint _age,
        address _addr
        ) public {
            
        require(!registeredUsers[_addr].dataIsSet, "This user is already registered.");
        
        Person memory _person = Person({
            name: _name,
            surname: _surname,
            countryCode: _countryCode,
            age: _age,
            addr: _addr,
            dataIsSet: true
        });

        registeredUsers[_addr] = _person;
    }

    function isRegisteredUser(address _addr) public view returns (bool) {
        return registeredUsers[_addr].dataIsSet;
    }
}
