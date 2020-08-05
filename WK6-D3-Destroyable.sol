import "./Ownable.sol";
pragma solidity 0.5.12;

contract HelloWorld is Ownable {

    struct Person {
        uint id;
        string name;
        uint age;
        uint height;
        bool senior;
    }

//EVENT
    event personCreated(string name, bool senior);

    uint public balance; //to hold balance


    // save effort to require what function execution costs
    modifier costs(uint cost) {
        require(msg.value >= cost);
        _;
    }



//MAPPING - for key-value lookups
    mapping(address => Person) private people;
    address[] private creators;

    function createPerson(string memory name, uint age, uint height, bool senior) public payable costs(1 ether){

    // REQUIRE - conditions to be met to execute
        require(age <= 150, "Age needs to be below 150");
        require(msg.value >= 1 ether);

    // to add offered msg.value to balance
        balance += msg.value;

        //people.push.Person(people.length, name, age, height);
        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;
        if (age > 65){
            newPerson.senior = true;
        }
        else {
            newPerson.senior = false;
        }
        insertPerson(newPerson);
        creators.push(msg.sender);

// ASSERT - to check for what shouldn't be possible
        assert(
            // reformat code to readable format
            keccak256(
                abi.encodePacked(
                    people[msg.sender].name,
                    people[msg.sender].age,
                    people[msg.sender].height,
                    people[msg.sender].senior
                    )
                )
        ==
            keccak256(
                abi.encodePacked(
                    newPerson.name,
                    newPerson.age,
                    newPerson.height,
                    newPerson.senior
                    )
                )
        );
        // EVENT launcher
        emit personCreated(newPerson.name, newPerson.senior);
    }

    function insertPerson(Person memory newPerson) private {
        address creator = msg.sender;
        people[creator] = newPerson;
    }

    function getPerson() public view returns(string memory name, uint age, uint height, bool senior){
        address creator = msg.sender;
        return(people[creator].name, people[creator].age, people[creator].height, people[creator].senior);
    }

    function deletePerson(address creator) public onlyOwner{
        delete people[creator];
        assert(people[creator].age == 0);
    }
    

    function getAddress(uint index) public view onlyOwner returns(address) {
        return creators[index];
    }

    //function to transfer funds out of the contract
    function withdrawAll() public onlyOwner returns(uint){
        uint toTransfer = balance;
        balance = 0;
        msg.sender.transfer(toTransfer);
        return toTransfer;
    }

    //SELFDESTRUCT - close contract
    function close() public onlyOwner {
        selfdestruct(msg.sender);
    }

}
