#!/bin/bash

set -e

# Generate bvault.conf
COIN=bvault
CONF="$HOME/.bvault/bvault.conf"

# if [ -e $CONF ]; then
# 	echo "Using existing configuration file ${CONF}"
#     exit 0
# fi;

if [ -z ${ENABLE_WALLET:+x} ]; then
    echo "disablewallet=${ENABLE_WALLET}" >> $CONF
fi;

if [ ! -z ${TESTNET:+x} ]; then
    echo "testnet=${TESTNET}" >> $CONF
fi;

if [ ! -z ${MAX_CONNECTIONS:+x} ]; then
    echo "maxconnections=${MAX_CONNECTIONS}" >> $CONF
fi;

echo "server=1" >> $CONF
echo "rpcbind=127.0.0.1" >> $CONF
echo "rpcallowip=10.0.0.0/0" >> $CONF

echo "Initialization completed successfully"

set -ex
exec bvaultd -printtoconsole "$@"