import "./People.sol";
pragma solidity 0.5.12;

contract Workers is People{

    struct Salary {
        uint amount;
    }

    People instance = People(0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);

    mapping(address => uint) public salary;

    function createWorker (string memory name, uint age, uint height, bool senior, address _address, uint _salary) public payable costs(100 wei){
        instance.createPerson.value(msg.value)(name, age, height, senior, _salary);

        salary[_address] =  _salary;
        require(age <= 75, "Age needs to be below 75");
    }
}
