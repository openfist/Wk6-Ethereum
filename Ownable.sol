pragma solidity 0.5.12;

contract Ownable {
    address public owner;


    //MODIFIER - to reduce repetition of code
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

     constructor() public{
        owner = msg.sender;
    }
}
