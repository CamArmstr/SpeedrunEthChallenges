import React, { useEffect } from "react";
import { Select, List, Spin, Collapse } from "antd";
import { Address } from "..";

const { Panel } = Collapse;

export default function Owners({
  ownerEvents,
  signaturesRequired,
  mainnetProvider,
  blockExplorer
}) {
    //   const owners = new Set();
    const owners = "0xBa35b40BD4848339844D9288a50E6cEeA8154346";
    // const prevOwners = new Set();
    const prevOwners = "0xBa35b40BD4848339844D9288a50E6cEeA8154346";
//     ownerEvents.forEach((ownerEvent) => {
//     if (ownerEvent.args.added) {
//       owners.add(ownerEvent.args.owner);
//       prevOwners.delete(ownerEvent.args.owner)
//     } else {
//       prevOwners.add(ownerEvent.args.owner)
//       owners.delete(ownerEvent.args.owner);
//     }
//   });

  return (
    <div>
      {/* <h2 style={{marginTop:32}}>Signatures Required: {signaturesRequired ? signaturesRequired.toNumber() :<Spin></Spin>}</h2> */}
      <h2 style={{marginTop:32}}>Signatures Required: {1}</h2>
      <List
        header={<h2>Owners</h2>}
        style={{maxWidth:400, margin:"auto", marginTop:32}}
        bordered
        dataSource={[...owners]}
        renderItem={(ownerAddress) => {
          return (
            <List.Item key={"owner_" + ownerAddress}>
              <Address
                // address={ownerAddress}
                address = {owners}
                ensProvider={mainnetProvider}
                blockExplorer={blockExplorer}
                fontSize={24}
              />
            </List.Item>
          )
        }}
      />

      <Collapse collapsible={prevOwners.size == 0 ? "disabled" : ""} style={{maxWidth:400, margin:"auto", marginTop:10}}>
        <Panel header="Previous Owners" key="1">
          <List
            dataSource={[...prevOwners]}
            renderItem={(prevOwnerAddress) => {
              return (
                <List.Item key={"owner_" + prevOwnerAddress}>
                  <Address
                    address={prevOwnerAddress}
                    ensProvider={mainnetProvider}
                    blockExplorer={blockExplorer}
                    fontSize={24}
                  />
                </List.Item>
              )
            }}
          />
        </Panel>
      </Collapse>
    </div>
  );
}