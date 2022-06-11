import { Contract } from "ethers";
import { task, types } from "hardhat/config";
import {STORE_DEPLOYMENT} from "./task-names";
import deployedContracts from "../deployments/deployment.json";
import fs from "fs";

task(STORE_DEPLOYMENT, "Deploy Hasher")
  .addParam<string>("contractname", "Contract Name", "", types.string)
  .addParam<string>("contractaddress", "Contract Address", "", types.string)
  .setAction(async (taskArgs, { ethers }): Promise<null> => {
        const networkID = await ethers.provider.getNetwork();

        const deployedContracts = require("../deployments/deployment.json");

        if (typeof deployedContracts[networkID.chainId] === "undefined") {
              deployedContracts[networkID.chainId] = {};
        }

        if (typeof deployedContracts[networkID.chainId][taskArgs.contractname] === "undefined") {
              deployedContracts[networkID.chainId][taskArgs.contractname] = taskArgs.contractaddress;
        } else {
              deployedContracts[networkID.chainId][taskArgs.contractname] = taskArgs.contractaddress;
        }

        fs.writeSync(
            fs.openSync("./deployments/deployment.json", "w"),
            JSON.stringify(deployedContracts, null, 2)
        );      return null;
  });
