import { accounts } from '../src/wallets/1k_accounts';
import { ten_accounts } from '../src/wallets/10_accounts';
import { selected_accounts } from '../src/wallets/selected_accounts';

const init = async () => {
    const factory = await hre.ethers.getContractFactory('NFTCollection');
    const [owner] = await hre.ethers.getSigners();
    const contract = await factory.deploy();
    const receipt = await contract.deployed();

    console.log('Gas used:', receipt.gasPrice.value, "\n");
    console.log('Contract deployed to:', contract.address, "\n");
    console.log("Contract deployed by (Owner): ", owner.address, "\n");

    // Mint an nft and wait for
    console.log('Airdrop to 1K accounts starting...', "\n");
    const txn = await contract.airdrop(accounts);
    await txn.wait();
    
    console.log("NFTs airdropped successfully!", "\n");

  console.log("Current NFT balances:", "\n")
  for (let i = 0; i < airdropAddresses.length; i++) {
    const bal = await contract.balanceOf(airdropAddresses[i]);
    console.log(`${i + 1}. ${airdropAddresses[i]}: ${bal}`);
  }

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