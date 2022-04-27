pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  address[] public owners;
  address[5] public dummy;

  mapping(address => bool) public isOwner;
  mapping(address => uint) public index;

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
    index[msg.sender] = 0;

    emit CurrentOwners(owners, block.timestamp);
    dummy[0] = address(0x637038769A98CD9C0E896a86bD395c864DEF00E9);
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

  function addSigner(address newSigner) onlyOwners public {
      require(isOwner[newSigner] != true, "already an owner, ya dingus");
      isOwner[newSigner] = true;

      owners.push(newSigner);
      emit AddSigner(newSigner);
      emit CurrentOwners(owners, block.timestamp);
  }

  function removeSigner(address removedSigner) onlyOwners public {
    require(msg.sender!=removedSigner, "that's yourself. Can't do that");
    require(isOwner[removedSigner]==true, "they're not a signer!");
    isOwner[removedSigner]=false;
    emit RemoveSigner(removedSigner);
  }



  function getMessageHash(
    address _to,
    uint _amount,
    string memory _message,
    uint _nonce
  ) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(_to, _amount, _message, _nonce));
  }

  // to support receiving ETH by default
  receive() external payable onlyOwners {}
  fallback() external payable {}
}
