import { ethers } from "hardhat";

async function deployMainFactory() {
  const MF = await ethers.getContractFactory("MainFactory");
  const MainFactoryi = await MF.deploy();

  await MainFactoryi.deployed();

  console.log("MainFactory deployed to:", MainFactoryi.address);
}

deployMainFactory().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
/*
 Node -> Ethers ( lib ) [ Providers , signers ] { RPC } ->
 */