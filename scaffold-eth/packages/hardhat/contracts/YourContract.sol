pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  address[] public owners;
  address[5] public dummy;

  mapping(address => bool) public isOwner;

  event Dummy(address[5] dummy);
  event GraffitiPublish(string graffitiTag, address tagger, address signers);
  event AddSigner(address addedSigner);
  event RemoveSigner(address removedSigner);
  event CurrentOwners(address[] currentOwners, uint256 timestamp);

  constructor() payable {
    // what should we do on deploy?
    uint totalBalance = msg.value;
    isOwner[address(0x637038769A98CD9C0E896a86bD395c864DEF00E9)] = true;
    owners.push(msg.sender);
    emit CurrentOwners(owners, block.timestamp);
    
    dummy[0] = address(0x637038769A98CD9C0E896a86bD395c864DEF00E9);
    // dummy.push(1);
    // dummy[1] = 1337;
    // dummy.push("grits dummy");

    emit Dummy(dummy);
  }

  modifier onlyOwners {
    require(isOwner[msg.sender] == true, "You're not an owner, bird brain");
    _;
    }
  

  //Tag the wall with the signed message and emit the array of signers
  //as part of the event.
  //Todo: Pass in an Array of signers to display on the wall??? 
  function tagWall(string memory newTag) onlyOwners public {
      console.log(msg.sender,"tagged the wall with ",newTag);
      emit GraffitiPublish(newTag, msg.sender, msg.sender);
  }


  // to support receiving ETH by default
  receive() external payable {}
  fallback() external payable {}
}
