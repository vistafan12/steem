---
permalink: /documentation/how-to-build/
title: How to build Steem
subtitle: Step by step instructions for building Steem from the sources
image: ../images/frontpage/icon-corporate-acc.svg
priority: 0
summary: >

---

This tutorials shows how to build STEEM from the sources and assumes
a Debian/Ubuntu based operating system. If you operate a different
Linux-based operating system, you may need to install dependencies
differently.

## Downloading the sources

The sources can be [downloaded from github](https://github.com/steemit/steem).

## Dependencies

### Development Toolkit

The following dependencies were necessary for a clean install of Ubuntu
14.04 LTS:

    sudo apt-get install gcc-4.9 g++-4.9 cmake make libbz2-dev libdb++-dev libdb-dev 
    sudo apt-get install libssl-dev openssl libreadline-dev autoconf libtool git

## Building STEEM

We can run `cmake` for configuration and compile with `make`:

    cmake -DBOOST_ROOT="$BOOST_ROOT" -DCMAKE_BUILD_TYPE=Release .
    make 

Note that the environmental variable `$BOOST_ROOT` should point to your
install directory of boost if you have installed it manually.

## Updating STEEM

For upgrading from source you only need to execute:

    git fetch
    git checkout <version>
    git submodule update --init --recursive
    cmake .
    make

## Distribution Specific Settings

### Boost 1.60

The Boost libraries which ships with may distributions might be too old.
You need to download the Boost tarball for Boost 1.60.0. 

    export BOOST_ROOT=$HOME/opt/boost_1_60_0
    sudo apt-get update
    sudo apt-get install autotools-dev build-essential g++ libbz2-dev libicu-dev python-dev
    wget -c 'http://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.bz2/download' \
         -O boost_1_60_0.tar.bz2
    tar xjf boost_1_60_0.tar.bz2
    cd boost_1_60_0/
    ./bootstrap.sh "--prefix=$BOOST_ROOT"
    ./b2 install

### Ubuntu 14.04

As `g++-4.9` isn't available in 14.04 LTS, you need to do this first:

    sudo add-apt-repository ppa:ubuntu-toolchain-r/test
    sudo apt-get update

If you get build failures due to abi incompatibilities, just use gcc 4.9

    CC=gcc-4.9 CXX=g++-4.9 cmake .

### Ubuntu 15.04

Ubuntu 15.04 uses gcc 5, which has the c++11 ABI as default, but the
boost libraries were compiled with the cxx11 ABI (this is an issue in
many distros). If you get build failures due to abi incompatibilities,
just use gcc 4.9:
 
    CC=gcc-4.9 CXX=g++-4.9 cmake .
