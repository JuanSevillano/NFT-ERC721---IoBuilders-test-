
const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('MyNFT');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log('Contract deployed to:', nftContract.address);


    // Mint an nft and wait for it
    let txn = await nftContract.makeAnNFT();
    const receipt = await txn.wait();
    

    // Second mint
    txn = await nftContract.makeAnNFT();
    await txn.wait();

}

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
}

runMain();