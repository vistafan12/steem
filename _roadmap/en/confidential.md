---
permalink: /roadmap/confidential/
title: Confidential Transfers
subtitle:  Adding Privacy to the Financial Transactions
image: ../images/roadmap/ico-confident-2.svg
priority: 6
summary: >
  Advances in cryptography have enabled cryptocurrencys to give users financial privacy while maintaining
  publicly verifyable ledgers.

---

# Privacy is Secondary Feature

The Steem network did not launch with confidential transactions because the state of the art is rapidly maturing
and confidential transfers and payments are not the primary purpose of the Steem network. That said, STEEM
and SBD have significant utility as a general purpose currency.

As the value held in by Steem users grows, it will become critical to give users the best financial privacy that
the network can support.

# Ring Confidential Transactions

The Monero project is pioneering the latest advancement in cryptocurrency privacy, [Ring Confidential Transfers](https://eprint.iacr.org/2015/1098.pdf).

Similar to Bitcoin, Monero is a cryptocurrency which is
distributed through a proof of work “mining” process. The original
Monero protocol was based on CryptoNote, which uses ring
signatures and one-time keys to hide the destination and origin
of transactions. Recently the technique of using a commitment
scheme to hide the amount of a transaction has been discussed
and implemented by Bitcoin Core Developer Gregory Maxwell. In
this article, a new type of ring signature, A Multi-layered Linkable
Spontaneous Anonymous Group signature is described which allows
for hidden amounts, origins and destinations of transactions
with reasonable efficiency and verifiable, trustless coin generation.
The author would like to note that early drafts of this were publicized
in the Monero Community and on the bitcoin research irc
channel.

# Limits on Confidential Transactions

Adding support for confidential transactions will require a blockchain hardfork. After the hardfork users will be able to
hold and transfer STEEM and STEEM Dollars with complete privacy. While transacting with confidential balances STEEM Dollars will
not earn interest. Because confidential transfers are not linked to any account, the built in rate limiting system cannot be used.
To prevent network spam, these transactions will also require fees to be paid. The fees will be dynamic based upon the current
bandwidth reserve ratio.

# User Experience

Making confidential usable requires either out-of-band communication or the scanning of all transactions. Scanning of all transactions is
not viable for light wallets, so out-of-band communication will be required. Steemit.com will integrate private messaging between users. Steemit.com will
know the two users are communicating, but no outside parties will know about the link.
