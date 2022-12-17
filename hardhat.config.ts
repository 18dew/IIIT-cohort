import * as dotenv from "dotenv";

import { HardhatUserConfig, task } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
import "hardhat-gas-reporter";
import "solidity-coverage";
import "hardhat-docgen";
import '@primitivefi/hardhat-dodoc';


// TASKS
import "./task/storeDeployment"
import "./task/deployMain"
import "./task/createMain"
import "./task/deployKYCToken"
import "./task/deployKYCGov"
// import "./task/deployKYCCore"
// import "./task/deployKYCIDReg"
// import "./task/deployKYCORGReg"

// TASKS

dotenv.config();

const mnemonic = process.env.MEMNONIC


// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

const config: HardhatUserConfig = {
  solidity: "0.8.2",
  networks: {
    polygonTestnet: {
      url: process.env.MUMBAI_RPC || '',
      accounts: {
        initialIndex: 1,
        mnemonic,
        path: "m/44'/60'/0"
      }
    },
  },
  docgen: {
    path: './docs',
    clear: true,
    runOnCompile: true,
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
  // dodoc: {
  //   runOnCompile: true,
  //   debugMode: true,
  //   // More options...
  // },
};

export default config;
