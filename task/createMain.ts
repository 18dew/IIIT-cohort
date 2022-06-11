import { Contract } from 'ethers'
import { task, types } from 'hardhat/config'

import {CREATE_MAIN_CONTRACT, STORE_DEPLOYMENT} from './task-names'

task(CREATE_MAIN_CONTRACT, 'Creates Main Contract from Main Factory')
    .addParam<string>("contractaddress", "Contract Address of Main Factory", "", types.string)
    .setAction(async (taskArgs, { ethers }): Promise<Contract> => {
        const hre = require('hardhat')
        const contractName = 'MainFactory'
        const C1 = await ethers.getContractFactory(contractName)

        const C1i = await C1.attach(taskArgs.contractaddress)
        await C1i.createMain();
        let CTR = await C1i.ctr();
        let NewMainContract = await C1i.MainAddr(CTR)
        console.log(`New Main Contract is created and address is  ${NewMainContract} `)

        await hre.run(STORE_DEPLOYMENT, { contractname: "MainContract", contractaddress: NewMainContract })

        return C1i
})
