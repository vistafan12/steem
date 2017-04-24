---
permalink: /documentation/how-use-wallet-via-json-rpc-over-http/
title: How to use wallet via JSON RPC
subtitle: Step by step instructions to interact with wallet over JSON-RPC
image: ../images/frontpage/icon-corporate-acc.svg
priority: 2 
summary: >

  This guide shows how to use the cli_wallet via JSON-RPC over HTTP. The <code>curl</code>
  command is used as an example. 

---

## Start a Test Network

This tutorial assumes that the `steemd` process is running on the local host and has been configured
with the RPC endpoint running on port 9876.
  
    # Endpoint for websocket RPC to listen on
      rpc-endpoint = 127.0.0.1:9876

## Launch CLI Wallet with HTTP Server 

Launch the CLI wallet and make sure it is configured to talk to the `steemd` process launched
in the prior step by passing in the `--rpc-server-endpoint`.  The second argument is the
endpoint upon which the `cli_wallet` will listen for incoming HTTP connections.

    ./cli_wallet --rpc-server-endpoint="ws://127.0.0.1:9876"  --rpc-http-endpoint="127.0.0.1:6789" 

If you would like to disable interactive input then you can use:

    ./cli_wallet --rpc-server-endpoint="ws://127.0.0.1:9876"  --rpc-http-endpoint="127.0.0.1:6789" --daemon 

## Request Data from the API

Fetch a Block by Number:

    curl --data-binary '{"id":"1","method":"get_block","params":[1]}' \
         http://127.0.0.1:6789

## Unlock your wallet:

    curl --data-binary '{"id":"1","method":"unlock","params":["testpassword"]}' \
         http://127.0.0.1:6789
    
## Transfer funds: 
    
    curl --data-binary '{"id":"2","method":"transfer","params":["initminer","scott","1.234 TESTS", "memo", "true"]}' \
         http://127.0.0.1:6789

      {"id":2,"result":{"ref_block_num":1881,"ref_block_prefix":1518310624,"expiration":"2016-03-29T18:51:42","operations":[["transfer",{"from":"initminer","to":"scott","amount":"1.234 TESTS","memo":"memo"}]],"extensions":[],"signatures":["20035a77f64d6d03b0d874c576efe101d2dad6ae64fec09390cad2b471ede75527601239dd0ee4c2d16d76792406ae48b8d5e4cf41c8b3dd9b42a90ee9aca84a81"],"transaction_id":"c5153e84342d59bc0a4b4bb7872fc3165722d213","block_num":1882,"transaction_num":0}}

You can use [jsonprettyprint.com](http://jsonprettyprint.com) to format the output in a more human friendly manner:

    {
      "id": 2,
      "result": {
        "ref_block_num": 1881,
        "ref_block_prefix": 1518310624,
        "expiration": "2016-03-29T18:51:42",
        "operations": [
          [
            "transfer",
            {
              "from": "initminer",
              "to": "scott",
              "amount": "1.234 TESTS",
              "memo": "memo"
            }
          ]
        ],
        "extensions": [
          
        ],
        "signatures": [
          "20035a77f64d6d03b0d874c576efe101d2dad6ae64fec09390cad2b471ede75527601239dd0ee4c2d16d76792406ae48b8d5e4cf41c8b3dd9b42a90ee9aca84a81"
        ],
        "transaction_id": "c5153e84342d59bc0a4b4bb7872fc3165722d213",
        "block_num": 1882,
        "transaction_num": 0
      }
    }

## Fetch a Transaction by ID:

    curl --data-binary '{"id":"1","method":"get_transaction","params":["c5153e84342d59bc0a4b4bb7872fc3165722d213"]}' \
         http://127.0.0.1:6789
    
    {"id":1,"result":{"ref_block_num":1881,"ref_block_prefix":1518310624,"expiration":"2016-03-29T18:51:42","operations":[["transfer",{"from":"initminer","to":"scott","amount":"1.234 TESTS","memo":"memo"}]],"extensions":[],"signatures":["20035a77f64d6d03b0d874c576efe101d2dad6ae64fec09390cad2b471ede75527601239dd0ee4c2d16d76792406ae48b8d5e4cf41c8b3dd9b42a90ee9aca84a81"],"transaction_id":"c5153e84342d59bc0a4b4bb7872fc3165722d213","block_num":1882,"transaction_num":0}}


