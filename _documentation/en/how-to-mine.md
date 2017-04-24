---
permalink: /documentation/how-to-mine/
title: How to mine STEEM
subtitle: Step by step instructions to start mining.
image: ../images/frontpage/icon-corporate-acc.svg
priority: 3 
summary: >

---

This tutorial assumes there is a functional network.
See [How to Start a Test Network](/documentation/how-to-start-a-testnet/) for information about starting your own test
network.

Mining requires operating a full node and building Steem from source. See [How to Build Steem](/documentation/how-to-build/) for
instructions on how to compile Steem on your platform.

## Configure a Witness Node (Miner)

A witness is any full node that processes and validates blocks. It is "witnessing" the real time blockchain. This is a
necessary prerequisite to produce blocks. We start by synchronizing with an existing network and let the witness node
create a data directory `datadir` for us that contains the default configuration file:

    cd programs/witness_node
    ./witness_node -d datadir 

Edit the following file `datadir/config.ini` and update the following lines to configure your witness to produce blocks.

    # Number of threads to use for proof of work mining
    mining-threads = 4

    # name of witness controlled by this node (e.g. initwitness )
    miner = ["your-account-name", "<PrivateKey-WIF>"]
    witness = "your-account-name"

Block production requires the private key associated with the active authority of the Miner. Mining accounts may only have
a single key set as the active authority.

## Start your Witness

After configuring your witness, simply start the witness and it will connect to the network. If
this is a test network then you may need to specify a seed-node.

    ./witness_node -d datadir

If your miner works well, you will see this message eventually:

    405992ms th_a       database.cpp:863              update_witness_sched ] scheduling miner <miner-name>

This means that the network has scheduled your miner for block production in the near future. Make sure that your
witness node is running at that time, otherwise you won't generate a block and won't get payed. If you do, you will see
a message after successful creation of a block similar to

    Generated block #645 with timestamp 2016-03-18T14:08:40 at time 2016-03-18T14:08:40 by <miner-name>

## Maximizing Miner Efficiency 

For best results a low-latency connection to the network is critical. A witness node has less than
3 seconds to do the work and get the result to the next scheduled witness for inclusion in a block. The sooner 
your node receives the block, the higher the probability that your work can propagate to the next node.

## Producing Blocks

Once your proof of work is accepted by the network it is critical that your node stays connected so
it can produce a block at the scheduled time. Each round (21 blocks) one miner gets to produce a block. A round can take at 
least 63 seconds if everyone produces a block. The miner queue length is proportional to the difficulty. 
Difficulty doubles with every additional 4 miners in the queue.  This means that from the time you submit a proof of work
until the time your miner gets scheduled to produce a block will be less than a fwe hours.

   If your node does not produce a block at the appointed time then you will not get paid.

## Key Security 

The active key (e.g. mining key) has access to the account's active funds and can thus be wiped empty on theft of the key.
Make sure you understand this risk and regularly move your funds over to another more secure account. 

### Keep Owner Key Offline

The proceeds of mining are deposited into your account as a vesting balance. This means that it takes 104 weeks to convert
mining income from *vesting STEEM* to STEEM.  If your `Owner Key` is kept in cold storage, then you will have 1 weeks notice
that your Active key has been compromised before 1% of your *vesting STEEM* is converted to STEEM and withdrawn. If you
detect an unauthorized operation then you can use your `Owner Key` to change the `Active Key` before you incur any losses.

### Configuration File Permissions

Mining requires access to the active authorities key. For best security the config file for your witness node should be configured
so that only the mining account has access to `config.ini`. On UNIX-like systems permissions should be `600 (-rw------)`. While it
is possible to pass the private key on the command line, this would expose the key to any user on your system.

## Mining from Multiple Computers

If you have more than one computer mining, then it is critical that only *one* of those computers is configured as a witness. To
configure a `steemd` process as a witness (but not a miner) you will need the following configuration settings:

    # WIF Private Key of a witness, starts with a 5...
    witness = "your-account-name"
    private-key = <PrivateKey-WIF>


**You must not specify a witness with the same account name, `your-account-name`, on more than one `steemd` instance** that has
the necessary private key.  If this happens then both instances of `steemd` will produce a block at the same time. Other nodes on the
network will see this double-signing and submit a proof to the network that will allow them to claim your entire account
balance.  


