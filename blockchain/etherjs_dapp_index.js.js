import "./styles.css";
import {
  useEthers,
  useEtherBalance,
  useTokenBalance,
  useContractFunction
} from "@usedapp/core";
import { Contract, utils } from "ethers";
import { MOCK_USDC } from "./addresses";
import { useState } from "react";

export default function App() {
  const { activateBrowserWallet, account } = useEthers();
  const balance = useEtherBalance(account);
  const tokenBalance = useTokenBalance(MOCK_USDC, account);
  const token = new Contract(MOCK_USDC, [
    "function mint(address receiver, uint256 amount) external",
    "function transfer(address recipient, uint256 amount) public"
  ]);
  const { send } = useContractFunction(token, "mint");
  const { send: transfer } = useContractFunction(token, "transfer");
  const { address, setAddress } = useState("");

  return (
    <div className="App">
      Welcome to building Dapp class!
      <br />
      <button onClick={activateBrowserWallet}> Connect </button>
      <br />
      {account}
      <br />
      {balance && utils.formatEther(balance)}
      <br />
      {tokenBalance && utils.formatUnits(tokenBalance, 6)}
      <br />
      <button onClick={() => send(account, utils.parseUnits("100", 6))}>
        Mint
      </button>
      <br />
      <input
        value={address}
        onChange={(event) => setAddress(event.target.value)}
      />
      <button
        onClick={() => {
          console.log(utils.parseUnits("0.1", 6));
          transfer(address, utils.parseUnits("0.1", 6));
        }}
      >
        {" "}
        Send{" "}
      </button>
    </div>
  );
}
