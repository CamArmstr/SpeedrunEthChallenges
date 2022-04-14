import { Alert, Button, Card, DatePicker, Divider, Input, notification, Progress, Slider, Spin, Switch } from "antd";
import { useContractReader } from "eth-hooks";
import { ethers } from "ethers";
import React, { useState } from "react";
import { Link } from "react-router-dom";
import { Address, Balance, Events, EventsAdmin } from "../components";

/**
 * web3 props can be passed from '../App.jsx' into your local view component for use
 * @param {*} yourLocalBalance balance on current network
 * @param {*} readContracts contracts from current chain already pre-loaded using ethers contract module. More here https://docs.ethers.io/v5/api/contract/contract/
 * @returns react component
 **/
function GraffitiApprovals({ 
  yourLocalBalance, 
  readContracts, 
  localProvider, 
  mainnetProvider,
  tx,
  writeContracts }) {
  // you can also use hooks locally in your component of choice
  // in this case, let's keep track of 'purpose' variable from our contract
  
  const openNotification = () => {
    notification.open({
      message: 'Congratulations!!',
      description:
        "You've just approved this graffiti. SAMO would be proud.",
      onClick: () => {
        console.log('Notification Clicked!');
      },
    });
  };
  const [newPurpose, setNewPurpose] = useState("loading...");


  return (
    <div>
      <div style={{ margin: 32 }}>
        <span style={{ marginRight: 8 }}>✏️</span>
        This is Event Listener 2 Test {" "}
        <div>
        <EventsAdmin
          contracts={readContracts}
          contractName="YourContract"
          eventName="GraffitiPublish"
          localProvider={localProvider}
          mainnetProvider={mainnetProvider}
          startBlock={1}
        />
      </div>
      </div>
      <div>
      <div style={{ margin: 8 }}>
          <Input
            
          />
      <Button
            style={{ marginTop: 8 }}
            onClick={openNotification}
          >
            Approve this Graffiti!
          </Button>
          <div>"_____________"</div>
          <div style={{ margin: 8 }}>
          <Input
            onChange={e => {
              setNewPurpose(e.target.value);
            }}
          />
          <Button
            style={{ marginTop: 8 }}
            onClick={async () => {
              /* look how you call setPurpose on your contract: */
              /* notice how you pass a call back for tx updates too */
              const result = tx(writeContracts.YourContract.tagWall(newPurpose), update => {
                console.log("📡 Transaction Update:", update);
                if (update && (update.status === "confirmed" || update.status === 1)) {
                  console.log(" 🍾 Transaction " + update.hash + " finished!");
                  console.log(
                    " ⛽️ " +
                      update.gasUsed +
                      "/" +
                      (update.gasLimit || update.gas) +
                      " @ " +
                      parseFloat(update.gasPrice) / 1000000000 +
                      " gwei",
                  );
                }
              });
              console.log("awaiting metamask/web3 confirm result...", result);
              console.log(await result);
            }}
          >
            Post this Graffiti!
          </Button> 
          </div>
          </div>
      </div>
    </div>
  );
}

export default GraffitiApprovals;
