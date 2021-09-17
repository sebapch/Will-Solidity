pragma solidity ^0.5.7;

contract Will {
    address owner;
    uint fortune;
    bool deceased;
    
    constructor() payable public {
        owner = msg.sender;
        fortune = msg.value;
        deceased = false;
        
    }
    
    //Create a modifier so only the owner can modify the contract
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    //Create a modifier so we can only allocate founds if the owner is deceased
    modifier mustBeDeceased{
        require(deceased == true);
        _;
    }
    
    address payable [] familyWallets;
    //map of inheritance
    mapping (address => uint) inheritance;
    
    //set inheritance for each address
    function setInheritance(address payable wallet, uint amount) public {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }
    
    //pay each family member based on their wallet address
    function payout() private mustBeDeceased {
        for(uint i = 0; i<familyWallets.length; i++) {
            //transfering the founds from contract address to receiver address
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
            
        }
    }
    //oracle switch simulation
    function hasDeceased() public onlyOwner {
        deceased = true;
        payout();
    }
    
}