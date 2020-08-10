pragma solidity 0.5.12;

contract People {
    function createPerson(string memory name, uint age, uint height) public payable;
}

contract Workers {

    modifier costs(uint cost) {
        require(msg.value >= cost);
        _;
    }

    struct Salary {
        uint amount;
    }

    People instance = People(0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);

    mapping(address => Salary) private salary;

    function createWorker (string memory name, uint age, uint height) public payable costs(100 wei){
        instance.createPerson.value(msg.value)(name, age, height);
    }
}
