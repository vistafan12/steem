---
permalink: /roadmap/ipfs/
title: IPFS Integration
subtitle:  Moving content to IPFS
image: ../images/roadmap/ico-ipfs.svg
priority: 3
summary: >
   The InterPlanetary File System (IPFS) is a new hypermedia distribution protocol, addressed by content and identities. IPFS enables the creation of completely distributed applications. It aims to make the web faster, safer, and more open. Steem will use IPFS to reference all content outside the blockchain.

---

# What is IPFS?

[IPFS](https://ipfs.io/) is a peer-to-peer distributed file system that seeks to connect all computing devices with the same system of files. In some ways, IPFS is similar to the Web, but IPFS could be seen as a single BitTorrent swarm, exchanging objects within one Git repository. In other words, IPFS provides a high throughput content-addressed block storage model, with content-addressed hyperlinks. This forms a generalized Merkle DAG, a data structure upon which one can build versioned file systems, blockchains, and even a Permanent Web. IPFS combines a distributed hashtable, an incentivized block exchange, and a self-certifying namespace. IPFS has no single point of failure, and nodes do not need to trust each other.

# Steem Integration

steemit.com which will allow users upload and store content on IPFS. When a user wishes to embed an image, video, or large text document in a post, steemit.com will transparently construct Steem posts that link to IPFS content. Steemit.com will then render Steem posts as-if the content was actually stored on the blockchain.

The benefit of this approach is that the data stored and maintained on the blockchain is kept to a minimum.

IPFS ensures that content referenced from URLs embedded in the blockchain cannot be changed.

# No Protocol Updates

The change to support IPFS will require no changes to the Steem protocol.
