pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  event GraffitiPublish(string graffitiTag, address tagger, address signers);

  string public purpose = "Building Unstoppable Apps!!!";

  constructor() payable {
    // what should we do on deploy?
  }

  //Tag the wall with the signed message and emit the array of signers
  //as part of the event.
  //Todo: Pass in an Array of signers to display on the wall??? 
  function tagWall(string memory newTag) public {
      console.log(msg.sender,"tagged the wall with ",newTag);
      emit GraffitiPublish(newTag, msg.sender, msg.sender);
  }


  // to support receiving ETH by default
  receive() external payable {}
  fallback() external payable {}
}
