import { Contract } from 'ethers'
import { task, types } from 'hardhat/config'

import { DEPLOY_KYC_IDREG, STORE_DEPLOYMENT} from './task-names'

task(DEPLOY_KYC_IDREG, 'Deploy Main Factory')
    .setAction(async (taskArgs, { ethers }): Promise<Contract> => {
        const hre = require('hardhat')
        const contractName = 'IDRegistry'
        const C1 = await ethers.getContractFactory(contractName)

        const C1i = await C1.deploy()
        await C1i.deployed()
        console.log(`Contract ${contractName} has been deployed to: ${C1i.address}`)

        await hre.run(STORE_DEPLOYMENT, { contractname: contractName, contractaddress: C1i.address })

        return C1i
})
