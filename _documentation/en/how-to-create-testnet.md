---
permalink: /documentation/how-to-start-a-testnet/
title: How to start a test network
subtitle: Step by step instructions to start a private testnet.
image: ../images/frontpage/icon-corporate-acc.svg
priority: 1
summary: >

---

These instructions assume you have already built the code. 

## Compiling for Test Network

The test network is configured slightly differently than the live network. You will have to configure `cmake` to 
build the source for the test network:

    cmake -DBUILD_STEEM_TESTNET=ON .
    -- BUILD_STEEM_TESTNET: ON
    --
    --              CONFIGURING FOR TEST NET
    --

    .... 
 
    -- Finished fc module configuration...
    --
    
                 CONFIGURED FOR TEST NETWORK
    
    -- Configuring done
    -- Generating done
    -- Build files have been written to: ...

    make


Assuming the above steps succeed you are ready to begin.


## Configure Steem Daemon 

First launch the `steemd` process once to generate the initial / default config.ini file and print the
default private key.

    cd programs/steemd
    ./steemd -d testnet 
    ------------------------------------------------------
    
                STARTING TEST NETWORK
    
    ------------------------------------------------------
    initminer public key: TEST6LLegbAgLAy28EHrffBVuANFWcFgmqRMW13wBmTExqFE9SCkg4
    initminer private key: 5JNHfZYKGaomSFvd4NUdQ9qMcEAC43kujbfjueTHpVapX1Kzq2n
    chain id: 18dcf0a285365fc58b71f18b3d3fec954aa0c141c44e4e5cb4cf777b9eab274e
    ------------------------------------------------------

Edit the following file `testnet/config.ini` and set these witnesses to produce blocks along with
the private key printed above.

    # name of witness controlled by this node (e.g. initminer )
      witness = "initminer"

    # WIF private key (may specify multiple times)
      private-key = 5JNHfZYKGaomSFvd4NUdQ9qMcEAC43kujbfjueTHpVapX1Kzq2n

    # Endpoint for P2P node to listen on
      p2p-endpoint = 0.0.0.0:3333

    # Endpoint for websocket RPC to listen on
      rpc-endpoint = 127.0.0.1:9876

## Start a Witness Node

Once the witness has been configured you can start the witness node like so:

     ./steemd -d testnet --enable-stale-production 

At this point you should see output like this:

      ....
      2745098ms th_a  witness.cpp:212 block_production_loo ] Generated block #1 with timestamp 2016-03-28T22:45:45 at time 2016-03-28T22:45:45 by initminer
      2747995ms th_a  witness.cpp:212 block_production_loo ] Generated block #2 with timestamp 2016-03-28T22:45:48 at time 2016-03-28T22:45:48 by initminer
      2750994ms th_a  witness.cpp:212 block_production_loo ] Generated block #3 with timestamp 2016-03-28T22:45:51 at time 2016-03-28T22:45:51 by initminer
      ....

## Start the CLI Wallet

The first step is to create a new wallet. Note: witness_node must be running on the same computer. 

    cd programs/cli_wallet 
    ./cli_wallet --server-rpc-endpoint="ws://127.0.0.1:9876"
    new >>> set_password "testpassword"
    locked >>> unlock "testpassword"
    unlocked >>> list_my_accounts 
    []
    unlocked >>> 

Before we can run any commands we must import the private key that controls the initminer account, this key is printed on startup.

    unlocked >>> import_key 5JNHfZYKGaomSFvd4NUdQ9qMcEAC43kujbfjueTHpVapX1Kzq2n
    true

    unlocked >>> list_keys
    [[
        "TST6LLegbAgLAy28EHrffBVuANFWcFgmqRMW13wBmTExqFE9SCkg4",
        "5JNHfZYKGaomSFvd4NUdQ9qMcEAC43kujbfjueTHpVapX1Kzq2n"
      ]
    ]

    unlocked >>> list_my_accounts
    initminer                17.000 TESTS       1.000000 VESTS            0.000 TBD
    -------------------------------------------------------------------------
    TOTAL                    17.000 TESTS       1.000000 VESTS            0.000 TBD


You will want to do this for all accounts. After this we can create new accounts for testing

    unlocked >>> create_account "initminer" "scott" "" true
    {
      "ref_block_num": 3673,
      "ref_block_prefix": 74705714,
      "expiration": "2016-02-16T21:54:04",
      "operations": [[
          "account_create",{
            "fee": "0.000 TESTS",
            "creator": "initminer",
            "new_account_name": "scott",
            "owner": {
              "weight_threshold": 1,
              "account_auths": [],
              "key_auths": [[
                  "STM5Tqg19fydUJpheNLtsanWQi8AYdcK8FiWr8W1PdeUfmFQSSjAo",
                  1
                ]
              ]
            },
            "active": {
              "weight_threshold": 1,
              "account_auths": [],
              "key_auths": [[
                  "STM7Rc77FhVoEU2TDcJiRv9fDXgZUon8vAtPPsAXyxaHTWw7wLtWD",
                  1
                ]
              ]
            },
            "memo_key": "STM5S9zfoMvfgenkGzwKLrKdeTrJRQnTJLAX9N4iXFVurEEVDKkkT",
            "json_metadata": ""
          }
        ]
      ],
      "extensions": [],
      "signatures": [
        "1f552f946600c4244231da804ba24be4c3e0fefdfc5ce61faa5528af775b32fa5f676a978323aef679b13f5c414d5bbed08fc9bfa5ae11ec5c1f8fe490a0a20829"
      ],
      "transaction_id": "b9aedb9a0d3f66f4588836bf307246c3b3e53a3f",
      "block_num": 3674,
      "transaction_num": 0
    }
    
    unlocked >>> list_my_accounts

    initminer                49.000 TESTS       1.000000 VESTS            0.000 TBD
    scott                     0.000 TESTS       0.000000 VESTS            0.000 TBD
    -------------------------------------------------------------------------
    TOTAL                    49.000 TESTS       1.000000 VESTS            0.000 TBD

In order for `scott` to transact he will need some vesting TEST:

    unlocked >>> transfer_to_vesting "initminer" "scott" "1.000 TESTS" true
    {
      "ref_block_num": 367,
      "ref_block_prefix": 697512891,
      "expiration": "2016-03-29T17:32:30",
      "operations": [[
          "transfer_to_vesting",{
            "from": "initminer",
            "to": "scott",
            "amount": "1.000 TESTS"
          }
        ]
      ],
      "extensions": [],
      "signatures": [
        "1f5950f65c93f369beee1637e5608eac50e7e2753311c69a3085f1acf4c2bebc215bffa6b6bd4c2d6455a540ee371c582f4d5ae707ec24354990e075051003756c"
      ],
      "transaction_id": "c29efe38e4a67d40e877a85c0caf6acdac4ce758"
      "block_num": 368,
      "transaction_num": 0
    }

    unlocked >>> list_my_accounts
    initminer               264.000 TESTS       1.000000 VESTS            0.000 TBD
    scott                     0.000 TESTS       1.000000 VESTS            0.000 TBD
    -------------------------------------------------------------------------
    TOTAL                   264.000 TESTS       2.000000 VESTS            0.000 TBD

For a full list of commands use the `help` command

All wallet operations will block until the operation has been included in the blockchain or an error occurs, generally speeking this should
be about 1.5 seconds on average and at most 6 seconds under normal network conditions.  

The result of the wallet operations include the block number the transaction was confirmed by the blockchain.


