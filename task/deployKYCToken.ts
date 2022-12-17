import { Contract } from 'ethers'
import { task, types } from 'hardhat/config'

import {DEPLOY_KYC_TOKEN, STORE_DEPLOYMENT} from './task-names'

task(DEPLOY_KYC_TOKEN, 'Deploy KYC Token')
    .addParam<string>("amount", "Amount of token to be minted", "", types.int)
    .setAction(async (taskArgs, { ethers }): Promise<Contract> => {
        const hre = require('hardhat')
        const contractName = 'KYCToken'
        const C1 = await ethers.getContractFactory(contractName)

        const C1i = await C1.deploy(taskArgs.amount)
        await C1i.deployed()
        console.log(`Contract ${contractName} has been deployed to: ${C1i.address}`)

        await hre.run(STORE_DEPLOYMENT, { contractname: contractName, contractaddress: C1i.address })

        return C1i
})
