pragma solidity 0.4.24;

contract AccessRestricted {
    address owner;
    mapping (address => bool) public admins;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    modifier accessRestricted() {
        require(msg.sender == owner || admins[msg.sender]);
        _;
    }
    
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
    
    function addAdmin(address newAdmin) public onlyOwner {
        admins[newAdmin] = true;
    }
    
    function deleteAdmin(address deletedAdmin) public onlyOwner {
        admins[deletedAdmin] = false;
    }
    
    function isAdmin(address _admin) public view returns (bool) {
        return admins[_admin];
    }
}
