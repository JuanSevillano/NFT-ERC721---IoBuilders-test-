
const init = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('MyNFT');
    const nftContract = await nftContractFactory.deploy();
    const receipt = await nftContract.deployed();
    console.log('Contract deployed to:', nftContract.address);
    console.log('Gas used:', receipt.gasUsed._hex);

    // Mint an nft and wait for it
    let txn = await nftContract.makeAnNFT();
    await txn.wait();

    // Second mint
    txn = await nftContract.makeAnNFT();
    await txn.wait();

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

runInit();