---
permalink: /documentation/consensus/
redirect_from:

title: Consensus Algorithm
subtitle: Ensuring a robust, censorship resistant social media platform.
image: ../images/frontpage/icon-dpos.svg
priority: 10
summary: >
    Consensus is the process by which a network of computers can reach an unambiguous agreement about who owns what. The goal
    of the consensus protocol is to make it difficult for anyone to create an alternative history, shut down the network, or
    censor individual users. Steem combines techniques used by Delegated Proof of Stake and Proof of Work mining to create a
    new protocol that is more robust and censorship resistant than any existing protocol.

---

Consensus is the process by which a group of individuals reach unambiguous agreement over the current state of a distributed ledger. 
The primary requirement for consensus is an agreement on the order of events and a deterministic algorithm for processing those events. 
A secondary requirement for consensus is censorship resistance.  Censorship resistance means that all individuals have an equitable 
opportunity to publish events in the ledger.

Every 21 blocks (a round), 21 individuals are selected to be the current set of active miners. Active miners are shuffled and
scheduled to produce a new block every 2 seconds.  The selection of active miners done in the following manner:

   - 19 top miner measured by vested STEEM holders approval voting
   - 1 miner seat is timeshared by all other miners
   - 1 miner seat is selected by proof of work mining.

## Approval Voting 

Every user may vote for any number of miners either directly, or indirectly via proxy voting. Proxy voting may be up to
3 levels deep. The process of voting is very similar to how Bitcoin miners vote for Mining Pools.  Only STEEM that is
committed to the network for over 1 year is allowed to vote. No one commits their capital for a year or more without being paid to
do so. We contend that the value of liquidity is just as real as the value of electricity and therefore both represent an objective 
measure of work.

## Scheduling Remaining Witnesses

The top 19 block producers are given high vote priority and get to produce blocks every round. The remaining individuals who wish 
to produce a block must take turns getting scheduled about once every 42 seconds.  The goal is to efficiently schedule these remaining 
producers proportional to the votes they have received. Someone with twice as many votes should be scheduled twice as often. The algorithm 
chosen is a variation of [weighted fair queueing](https://en.wikipedia.org/wiki/Weighted_fair_queueing) (WFQ). WFQ assigns each block producer a 
virtual time based upon their vote weight and how long they have been waiting to produce a block. Any time votes change the virtual time is 
updated to reflect the new priority. At the start of each round, the block producer with the lowest virtual time is selected to produce a 
block and their position is moved to the back of the queue.

If the individual fails to produce a block then the network will simply skip a block. If none of these remaining miners produce a block 
then the network will still be 95% reliable at producing blocks every 2 seconds.

## Proof of Work

We would like to have the benefits of Proof of Work (aka mining) without the downsides such as unpredictable block production time, 
mining pool centralization, or the potential for recent blocks to be orphaned. The primary benefits of POW include:

- An objective measure of quality that is expensive to forge 
- A financial incentive to optimize a useful/necessary computer algorithm 
- A distribution model that attracts tech-savvy users
- Creation of a robust low-latency network

Unlike traditional mining, block production time is separated from the time when work is performed. When a solution is found that meets the target difficulty, 
a transaction is submitted the network and included by the current block producer. To be included, the POW must be derived from the current head block. 
The user is then added to a queue to be included in a future block production round. The target difficulty becomes a function of the queue length. 
A simple algorithm would require a number of leading 0 bits of a POW hash equal to the number of producers in the queue.

With two-second block times, a POW miner needs to operate a node with minimal network latency so it can get the new head-block as quickly as possible and then 
submit its result to the network with enough time to propagate to the next block producer.  The introduction of a mining pool would add additional latency that 
would dramatically reduce the percentage of time available to actually do work.

### Mining Algorithm

While any mining algorithm could be used, we would like to introduce a new algorithm that has several beneficial properties. The mining algorithm requires proof that the miner possess the private key for the account that will ultimately produce the block and receive the reward. The algorithm also requires the user to do an elliptic curve signature verification, the optimization of which will benefit the validation of all transactions and lower the cost of operating the network in the long run.


    Let HASH = a secure cryptographic hash function (SHA256 or better)
    Let H    = Head Block ID
    Let H2   = HASH(H+NONCE)
    Let PRI  = Producer Private Key
    Let PUB  = Producer Public Key
    Let S    = SIGN(PRI, HASH( H ) )
    Let K    = RECOVER_PUBLIC_KEY( H2, S )
    Let POW  = HASH( K )

To be valid the POW must be less than the target difficulty and RECOVER_PUBLIC_KEY(H2,S) must equal PUB. The miner introduces randomness in either the selection of the NONCE or via the randomness required for elliptic curve signature generation. This, combined with the private key selection should ensure that no two miners are searching the same work space.

By starting and ending the POW with a cryptographically secure hash function we can ensure that any vulnerabilities or computational shortcuts that may exist in the RECOVER_PUBLIC_KEY algorithm or SIGN algorithm will ultimately cause the POW algorithm to revert back to a simple HASH-based POW.

## Double Spend Attack

A double spend can occur anytime a blockchain reorganization excludes a transaction previously included.  This means
that the miners had a communication breakdown caused by disruptions in the infrastructure of the Internet.  With
DPOW, the probability of a communication breakdown enabling a double spend attack is very low.

The network is able to monitor its own health and can immediately detect any loss in communication which shows up as
miners failing to produce blocks on schedule.  When this occurs, it may be necessary for users to wait until half of
the miners have confirmed their transactions, which could be up to 42 seconds.

## Transactions as Proof of Stake

Each transaction on the network may optionally include the hash of a recent block.  If this is done, the signer of the
transaction can be confident that their transaction may not be applied to any blockchain that does not include that
block.  A side effect of this process is that, over time, all stakeholders end up directly certifying the long-term
integrity of the transaction history.

## Blockchain Reorganizations

Because the vast majority miners are elected, highly accountable, and granted dedicated time slots to produce blocks, there is
rarely any situation where two competing chains can exist.  From time to time, network latency will prevent one miner
from receiving the prior block in time.  If this happens, the next miner will resolve the issue by building on whichever
block they received first. After 14 confirmations (about 30 seconds) the transaction has been confirmed by 2/3 of the active
miners which means there is no possibility of reversal without manual intervention.

While the system is robust against *natural* chain reorganization events, there is still some potential for software
bugs, network interruptions, or incompetent or malicious miners to create multiple competing histories that are
longer by a block or two.  The software always selects the blockchain with the highest miner participation rate.  
miner operating on their own can only produce one block per round and will always have a lower participation rate than the majority.
There is nothing that any miner (or minority group of miners) can do to produce a blockchain with a higher participation rate.    
The participation rate is calculated by comparing the expected number of blocks produced in a given period of time to the actual 
number of blocks produced.

## Maximally Decentralized

Under DPOW, every stakeholder has influence that is directly proportional to their stake, and no stakeholders are excluded
from exercising this influence.  Everyone who wishes to participate in the process has an opportunity to produce a block without
having to participate in a political campaign for votes.  Every other consensus system on the market excludes the vast majority of 
stakeholders from participating.  There are many different ways that alternatives exclude stakeholders: some alternatives use invite-only systems, 
others exclude participation by making it cost more to participate than they earn.  Still other systems technically allow everyone to
participate, but they can be safely ignored by a few large players who produce the vast majority of all blocks.  Only DPOW ensures that 
block production is evenly distributed among the most people and that everyone has an economically viable way to influence who those people are.


