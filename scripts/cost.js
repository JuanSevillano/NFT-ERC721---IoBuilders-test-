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
        Outcome: // Art Exhibition
        2845483 * 0.000000007 = 0,019918381 eth * 1600$ = ~ 32$

        Outcome: // Tickets project 
        25120903 * 0.000000008 = 0,200967224 eth * 1600 =~ 320$ per Smart contract
        Developer Smart-contract / month = 
        Frontend: Landing, conectar a wallet. Mint / Stake / rewards / withdraw
        Backend: (Conectar blockchain, crear servicios nesearios del modelo de negocio )
     */