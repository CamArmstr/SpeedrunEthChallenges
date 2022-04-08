pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amountOfTokens, uint256 amountOfETH);


  YourToken public yourToken;
  uint256 public constant tokensPerEth = 100;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);

    
  }

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    uint ethAmount = msg.value;
    uint256 tokenAmount = ethAmount * tokensPerEth;
    yourToken.transfer(msg.sender, tokenAmount);
    emit BuyTokens(msg.sender, ethAmount, tokenAmount);
  }
  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() public onlyOwner {
    address payable to = payable(msg.sender);
    to.transfer(address(this).balance);
  }

  // ToDo: create a sellTokens() function:
  function sellTokens(uint theAmount) public returns (bool) {
    yourToken.transferFrom(msg.sender, address(this), theAmount);
    payable(msg.sender).transfer(theAmount/tokensPerEth);
    emit SellTokens(msg.sender, theAmount, theAmount/tokensPerEth);
    return true;
  }

function approve(address _spender, uint256 _value) public returns (bool success) {}

}
