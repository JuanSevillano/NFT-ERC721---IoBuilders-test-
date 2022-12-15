const wallets = [
    '0xC81784A8C51B0F3B64759C49e27BfF363b9f9c92',
    '0x766318f112b83a4b6f1282fbd0faf9b01f563541',
    '0x306e5eb9ff2bbadcd5aaa8d56819e18e9c1d24e5',
]

const init = async () => {
    const factory = await hre.ethers.getContractFactory('NFTCollection');
    const [owner] = await hre.ethers.getSigners();
    const contract = await factory.deploy();
    const receipt = await contract.deployed();

    const transaction = await receipt.deployTransaction.wait();

    // console.log('Deploy transaction:', transaction, "\n");
    // console.log('Contract :', receipt, "\n");
    console.log('Contract deployed to:', contract.address, "\n");
    console.log("Contract deployed by (Owner): ", owner.address, "\n");

    return contract
}


const mintToWallets = async (contract) => {
    let minted = [];
    
    for(let i = 0; i < wallets.length; i++){
        const address = wallets[i];
        const tnx = await contract.publicMint(address);
        const nft = await tnx.wait();
        console.log('minted to: ', address);
        console.log('taxn hash: ', nft.transactionHash);
        const userMinted = {
            address,
            token: nft.token
        }
        minted.push(userMinted);
    }
    
    return minted;
}

const revealCollection = async (contract) => {
    const newBaseURI = 'https://ipfs.io/ipfs/QmVVLtcxJssGstMHeuJuWwiYaXd29ZqGJNX2Af1DXJssv9?filename='

    const prevURI = await contract.baseURI(); // check new baseURI
    console.log('Previous baseURI: ', prevURI);

    await contract.reveal(true); // revealed
    await contract.setRevealURI(newBaseURI); // setBaseURI

    const response = await contract.baseURI(); // check new baseURI
    console.log('Response baseURI: ', response);
}


const runInit = async () => {
    try {
        console.log('==============', 'Start deploy smart-contract','==============');
        const contract = await init();
        console.log('==============', 'Finished','==============');

        console.log('==============', 'Start mint previous reveal','==============');
        const minted = await mintToWallets(contract);
        console.log('Minted', minted);
        console.log('==============', 'Finished','==============');
        
       return contract
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
}

runInit().then((contract) => {
    console.log('finished: SC Address: ', contract.address)
    // try{
    //     setTimeout(async () => {
    //         console.log('==============', 'Start revealing','==============');
    //         await revealCollection(contract)    
    //         console.log('==============', 'Finished','==============');
    //         process.exit(0);
    //     }, 5 * 60 * 100);
    // } catch (error) {
    //     console.log(error);
    //     process.exit(1);
    // }
})