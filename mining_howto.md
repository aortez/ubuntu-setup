# Instructions
1. First, we need to create a wallet.  One way it so use the program `geth`.  You can grab the newest version here:
        https://github.com/ethereum/go-ethereum/archive/v1.7.3.tar.gz
`geth` is the "go-etherium miner", it can do CPU-based mining, which is too slow
to do for profit.  However it can do other very valuable stuff also.
2. Unarchive it somewhere.
3. Run this command 'creating an account' to create your wallet
https://github.com/ethereum/go-ethereum/wiki/Managing-your-accounts#creating-an-account
  ```
  $ geth account new
  Your new account is locked with a password. Please give a password. Do not forget this password.
  Passphrase:
  Repeat Passphrase:
  Address: {xxxx}
  ```
4. Edit the following script by setting your public wallet address and mining box name.
  ```
  oldman@oldman-desktop2 /home/data/ether/bin $ cat go.sh
  #!/bin/bash
  PUBLIC_WALLET_ADDRESS=5ab409037882d8efd890b69ef2491f01d711e9b8 # this is where the payment for mining will go
  MINER_NAME=desktop2 # used to distinguish between multiple miners contributing to a single wallet
  GPU_FORCE_64BIT_PTR=0 # I don't know the exact purpose of these commands
  GPU_MAX_HEAP_SIZE=100
  GPU_USE_SYNC_OBJECTS=1
  GPU_MAX_ALLOC_PERCENT=100
  GPU_SINGLE_ALLOC_PERCENT=100

  # get to mining!
  ./ethminer --farm-recheck 200 -G -S eu1.ethermine.org:4444 -FS us1.ethermine.org:4444 -O $PUBLIC_WALLET_ADDRESS.$MINER_NAME
  ```
5. Then you run the script to start mining.  Following is an explanation of
what's going on.

# Explanation
You can mine _solo_ or in a _pool_, however mining solo these days is impractical due to
the low payout rate.  This is because the process of mining is basically a series
of random attempts to compute an acceptible hash for a block and this process takes
a lot of cpu cycles.  This block somehow then makes it to the _blockchain_.

The above script is mining as part of the _ethermine_ pool.

Anyway, you want to mine in a pool and share the work so you can get a payout at
a regular frequency. The quantity of the payout is somehow determined by the
number of _valid shares_ that your miner submits.  I think the number of valid
shares you've computed is reflected by the `A1` part of the ethminer script's
log output. The following line shows 1 valid share computed since the beginning
 of this mining run.
```
  m  22:55:40|ethminer  Speed  29.80 Mh/s    gpu/0 29.80  [A1+0:R0+0:F0] Time: 00:01
```

A valid share is actually not of value to the network... but we do use them as a
way to estimate how much an individual miner contributions to the work of
hashing a block, as the frequency that these _close enough_ hashes can be
computed is somehow predictive of how long it takes to compute a block.

There are a lot of features that differ between different mining pools.
One of the features is how they payout.  Generally I think they payout after
some time frequency and/or some threshold amount of value mined.  For example, the
pool I am using pays out weekly regardless of how much eth you are deemed to be
owed for the mining contribution.  It also pays out whenever your yet to be paid
contribution passes some threshold, like 0.1 ether.

Based on reading posts on various ethererum related boards I chose ethermine as
my mining pool.  It sounds like there are a number of fine choices to make, with
ethermine being just one of them.  If you are fine with using ethermine, then
the miner launch script provided above will need no further modification.  If
you do want to use a different pool however, they will probably have
instructions posted online somewhere to

Some example numbers: With my 2x 1080s I'm computing ~60 MH/sec.  I only mine
part time, basically whenever I remember to turn the miner back on.  I turn
mining off when I'm using the machine though, as it makes the GPU laggy.  And
this then makes the UI quite laggy.

Here's a forum that you can search to find more info (this link is to a specific post though):
https://forum.ethereum.org/discussion/13308/been-successfully-mining-now-what

# Misc notes
If you start up the geth console you can use it to interact with the blockchain.
But first it needs to download a local copy. This consumes 10s of GBs.
It automatically downloads the current blockchain in the background when it
starts up.  Here's an example of checking your account balance.
```
# start geth, using your public wallet address
geth console --etherbase 5ab409037882d8efd890b69ef2491f01d711e9b8
# run this command in the geth console
web3.fromWei(eth.getBalance(web3.eth.accounts[0]), "ether")
```
You can also use it to do other stuff, such as move eth between wallets.

There are a lot of "block inspector"-type sites that can look up the balance of
your wallet, given your public wallet address.  You can check your balance at
these types of places.
```
# check balance online?
https://etherscan.io/address/0x5ab409037882d8efd890b69ef2491f01d711e9b8
```

If you do use ethermine, it has some features for monitoring your miner's progress.
```
# check on how our miners are doing:
https://ethermine.org/miners/5ab409037882d8efd890b69ef2491f01d711e9b8
```
