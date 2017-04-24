---
permalink: /documentation/how-monitor-account-deposits/
title: How to monitor an account for deposits
subtitle: Step by step instructions for account monitoring
image: ../images/frontpage/icon-corporate-acc.svg
priority: 2 
summary: >

  This guide shows how to monitor accounts and process deposits to
  a specific account via Python or JavaScript. It is also a useful
  introduction to the block, transaction, and operation structures used
  by Steem.

---

## The Steem Blockchain

The underlying technology if STEEM is very similar to the Graphene technology used in other blockchains. It consists of hash-linked blocks that may contain several transactions. In contrast to Bitcoin, each transaction can itself contain several operations that perform certain tasks (e.g. transfers, vote and comment operations, vesting operations, and many more).

This article will show how to read and interpret **transfer** operations on order to process customer deposits. In order to distinguish customers, we will make use of *memos* that can be attached to each transfer. Note, that these memos are stored on the blockchain in plain text.

### Transfer Operation

A transfer operations takes the following form:

    {
      "from": "hello",
      "to": "world",
      "amount": "10.000 STEEM",
      "memo": "mymemo"
    }

where `from` and `to` identify the sender and recipient. The amount is a space-separated string that contains a floating point number and the symbol name `STEEM`. As mentioned above, the sender can attach a memo which is stored on the blockchain in plain text.

### Operations

Each operation is identified by an operation identifier (e.g. `transfer`) together with the operation-specific data and are bundled into an array of *operations*:

    [
      [OperationType, {operation_data}],
      [OperationType, {operation_data}],
      [OperationType, {operation_data}],
    ]

Several operations can be grouped together but they all take the form `[OperationType, {data}]`:

    [
      ["transfer", {
          "from": "hello",
          "to": "world",
          "amount": "10.000 STEEM",
          "memo": "mymemo"
          }
       ],
       ["transfer", {
          "from": "world",
          "to": "trade",
          "amount": "15.000 STEEM",
          "memo": "Gift!"
          }
       ]
    ]

The set of operations is executed in the given order. Given that STEEM has a single threaded business logic, all operations in a transaction are guaranteed to be executed atomically.

### Transactions

The set of operations is stored in a transaction that now carries the required signatures of the accounts involved, an expiration date as well as some parameters required for the TaPOS/DPOS consensus scheme.

    [
      {"ref_block_num": 29906,
       "ref_block_prefix": 1137201336,
       "expiration": "2016-03-30T07:15:00",
       "operations": [[
           "transfer",{
             "from": "hello",
             "to": "world",
             "amount": "10.000 STEEM",
             "memo": "mymemo"
           }
         ]
       ],
       "extensions": [],
       "signatures": ["20326......"]
       }
    ]

### Block

Several transactions from different entities are then grouped into a block by the block producers (e.g. witnesses and POW miners). The block carries the usual blockchain parameters, such as the transaction merkle root, hash of the previous block as well as the transactions.

    {
      "previous": "000274d2b850c8433f4c908a12cc3d33e69a9191",
      "timestamp": "2016-03-30T07:14:33",
      "witness": "batel",
      "transaction_merkle_root": "f55d5d65e27b80306c8e33791eb2b24f58a94839",
      "extensions": [],
      "witness_signature": "203b5ae231c....",
      "transactions": [{
          "ref_block_num": 29906,
          "ref_block_prefix": 1137201336,
          "expiration": "2016-03-30T07:15:00",
          "operations": [[
              "transfer",{
                "from": "hello",
                "to": "world",
                "amount": "10.000 STEEM",
                "memo": "mymemo"
              }
            ]
          ],
          "extensions": [],
          "signatures": [
            "20326d2fe6e6ba..."
          ]
        }
      ],
      "block_id": "000274d3399c50585c47036a7d62fd6d8c5b30ad",
      "signing_key": "STM767UyP27Tuak3MwJxfNcF8JH1CM2YMxtCAZoz8A5S8VZKQfZ8p",
      "transaction_ids": [
        "64d45b5497252395e38ed23344575b5253b257c3"
      ]
    }

Furthermore, the call `get_block <blocknumber>` returns the transaction ids (i.e. the hashes of the signed transaction produced by the sender) that uniquely identify a transaction and thus the containing operations.

## Monitoring Deposits

Now that we have discussed the underlying structure of the STEEM blockchain, we can look into monitoring account deposits.

### Running a Node

First, we need to run a full node in a trusted environment:

      ./programs/steemd/steemd --rpc-endpoint=127.0.0.1:8092

We open up the RPC endpoint so that we can interface with the node using RPC-JSON calls.

### Blockchain Parameters and Last Block

The RPC call `get_config` will return the configuration of the blockchain which contains the block interval in seconds. By calling `get_dynamic_global_properties`, we obtain the current head block number as well as the last irreversible block number. The difference between both is that the last block is last block that has been produced by the network and has thus been confirmed by the block producer. The last irreversible block is that block that has been confirmed by sufficient many block producers so that it can no longer be modified without a hard fork. Every block older than the last reversible block is equivalent to a checkpoint in Bitcoin. Initially they are about 30 to 50 blocks behind the head block, but after the first 30 days they are about 15 blocks ( 45 seconds ) behind the head block.

A particular block can be obtained via the `get_block <blocknumber>` call and takes the form shown above.

### Processing Block Data

Since the content of a block is unencrypted, all it takes to monitor an account is processing of the content of each block.

# Example

The following will show example implementations for monitoring a specific account.

## Python

      # This library can be obtain from https://github.com/xeroc/python-steem

      from steemrpc import SteemRPC
      from pprint import pprint
      import time

      """
         Connection Parameters to steemd daemon.

         Start the steemd daemon with the rpc-endpoint parameter:

            ./programs/steemd/steemd --rpc-endpoint=127.0.0.1:8092

          This opens up a RPC port (e.g. at 8092). Currently, authentication
          is not yet available, thus, we recommend to restrict access to
          localhost. Later we will allow authentication via username and
          passpword (both empty now).

      """
      rpc = SteemRPC("localhost", 8092, "", "")

      """
          Last Block that you have process in your backend.
          Processing will continue at `last_block + 1`
      """
      last_block = 160900

      """
          Deposit account name to monitor
      """
      watch_account = "world"


      def process_block(block, blockid):
          """
              This call processes a block which can carry many transactions

              :param Object block: block data
              :param number blockid: block number
          """
          if "transactions" in block:
              for tx in block["transactions"]:
                  #: Parse operations
                  for opObj in tx["operations"]:
                      #: Each operation is an array of the form
                      #:    [type, {data}]
                      opType = opObj[0]
                      op = opObj[1]

                      # we here want to only parse transfers
                      if opType == "transfer":
                          process_transfer(op, block, blockid)


      def process_transfer(op, block, blockid):
          """
              We here process the actual transfer operation.
          """
          if op["to"] == watch_account:
              print(
                  "%d | %s | %s -> %s: %s -- %s" % (
                      blockid,
                      block["timestamp"],
                      op["from"],
                      op["to"],
                      op["amount"],
                      op["memo"]
                  )
              )


      if __name__ == '__main__':
          # Let's find out how often blocks are generated!
          config = rpc.get_config()
          block_interval = config["STEEMIT_BLOCK_INTERVAL"]

          # We are going to loop indefinitely
          while True:

              # Get chain properies to identify the 
              # head/last reversible block
              props = rpc.get_dynamic_global_properties()

              # Get block number
              # We here have the choice between
              #  * head_block_number: the last block
              #  * last_irreversible_block_num: the block that is confirmed by
              #    2/3 of all block producers and is thus irreversible!
              # We recommend to use the latter!
              # block_number = props['head_block_number']
              block_number = props['last_irreversible_block_num']

              # We loop through all blocks we may have missed since the last
              # block defined above
              while (block_number - last_block) > 0:
                  last_block += 1

                  # Get full block
                  block = rpc.get_block(last_block)

                  # Process block
                  process_block(block, last_block)

              # Sleep for one block
              time.sleep(block_interval)

## NodeJS

      var rpc = require('node-json-rpc');

      var last_block = 160900;
      var watch_account = "world";
      var options = {
          port: 8092,
          host: '127.0.0.1',
          path: '/rpc',
          strict: false
      };


      var callrpc = function(name, params, cb) {
          client.call(
              {"jsonrpc": "2.0",
               "method": name,
               "params": params,
               "id": 0},
              function(err, res) {
                 if (err) { cb(err, null) }
                 else { cb(null, res["result"]) }
              }
          );
      }

      var process_transfer = function(op, block, blockid) {
          console.log(block);
          if (op["to"] == watch_account) {
              console.log(blockid + " | " + 
                          block["timestamp"] + " | "+
                          op["from"] + " -> " +
                          op["to"] + ": " +
                          op["amount"] + " -- " +
                          op["memo"]
                  );
          }
      }

      var process_block = function(block, blockid) {
          console.log(blockid);
          console.log(block["transactions"]);
          for (var tx in block["transactions"]) {
              for (var opObj in tx["operations"]) {
                  var opType = opObj[0];
                  var op = opObj[1];

                  console.log(op);

                  if (opType == "transfer") {
                      process_transfer(op, block, blockid);
                  }
              }
          }
      }

      var start_loop = function() {
          callrpc("get_dynamic_global_properties", [], function(err, props) {
              var block_number = props["last_irreversible_block_num"];
              while ((block_number - last_block) > 0) {
                  last_block += 1
                  callrpc("get_block", [last_block], function(err, block) {
                      process_block(block, last_block);
                  });
              }
          });
      }


      var client = new rpc.Client(options);

      var block_interval;

      callrpc("get_config", [],
              function (err, config) {
                  if (err) { console.log(err); }
                  else {
                      block_interval = config["STEEMIT_BLOCK_INTERVAL"]
                      start_loop();
                  }
              }
             )

