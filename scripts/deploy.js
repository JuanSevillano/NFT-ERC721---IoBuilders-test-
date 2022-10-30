const init = async () => {
    const factory = await hre.ethers.getContractFactory('NFTCollection');
    const [owner] = await hre.ethers.getSigners();
    const contract = await factory.deploy();
    const receipt = await contract.deployed();

    const transaction = await receipt.deployTransaction.wait();

    console.log('Deploy transaction:', transaction.gasUsed.value, "\n");
    console.log('Contract deployed to:', contract.address, "\n");
    console.log("Contract deployed by (Owner): ", owner.address, "\n");
    
    // // Mint an nft and wait for
    // console.log('Airdrop to 1K accounts starting...', "\n");
    // const txn = await contract.airdrop(wallets);
    // await txn.wait();
    // console.log('Airdrop receipt:', txn, "\n");
    
    // console.log("NFTs airdropped successfully!", "\n");

    // console.log("Current NFT balances:", "\n")
    // for (let i = 0; i < wallets.length; i++) {
    //     const bal = await contract.balanceOf(wallets[i]);
    //     console.log(`${i + 1}. ${wallets[i]}: ${bal}`);
    // }

    /**
     *  USD Cost of deployment =
     *  Units (gasPrice) * ETH price per unit * USD value per eth 
     * 
     * Data = 
        Units = 2845483
        MED GAS PRICE
        7 Gwei ($0.24)
        0.000000007 Eth = 7Gwei
        1Eth = 1600$
     *
     *
        Outcome: 
        2845483 * 0.000000007 = 0,019918381 eth * 1600$ = ~ 32$
     */

}

const runInit = async () => {
    try {
        await init();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
}

const wallets = [
    '0x766318f112b83a4b6f1282fbd0faf9b01f563541',
    '0x306e5eb9ff2bbadcd5aaa8d56819e18e9c1d24e5',
    '0xc707174a6d5d5d49d42895a09227cf55aabc00cb',
    '0xa5999e05d84b8709f701f6addbc307ba49d6822f',
    '0xC81784A8C51B0F3B64759C49e27BfF363b9f9c92',
]

runInit();