// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {

  ExampleExternalContract public exampleExternalContract;

  constructor(address exampleExternalContractAddress) public {
      exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  }

  mapping (address => uint256) public balances;
  uint256 public constant threshold = 1 ether;
  uint256 public deadline = block.timestamp + 72 hours;
  bool public executeCheck = true;
  bool public openForWithdraw = false;
  bool public isComplete = false;

  event Stake(address indexed _sender, uint256 _amount);

  modifier notCompleted {
    require(!exampleExternalContract.completed(), "Already Completed");
    _;
  }

  receive() external payable {
    this.stake();
    balances[msg.sender] += msg.value;
  }

  function stake() public payable {
    balances[msg.sender] += msg.value;
    emit Stake(msg.sender, msg.value);
  }

  function execute() public notCompleted {
    require(executeCheck, "Already Called");
    executeCheck = false;
    if (address(this).balance >= threshold && this.timeLeft()==0) {
      exampleExternalContract.complete{value: address(this).balance}();
      balances[msg.sender] = 0;
    }
    openForWithdraw = true;
  }

  function timeLeft() public view returns (uint256) {
    if (block.timestamp >= deadline) {
      return 0;
    }
    return deadline - block.timestamp;
  }


  function withdraw() public notCompleted {
    require(openForWithdraw,"Not Executed Yet");
    uint amount = balances[msg.sender];
    balances[msg.sender] = 0;
    (bool sent, bytes memory data) = msg.sender.call{value: amount}("");
    require(sent, "Failed to Withdraw");
  }

}
