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

# set ipv4, ipv6 or onion
if [ ! -z ${ONLYNET:+x} ]; then
    echo "onlynet=${ONLYNET}" >> $CONF
fi;

if [ ! -z ${RPC_SERVER:+x} ]; then
	RPC_USER=${RPC_USER:-bvaultrpc}
	RPC_PASSWORD=${RPC_PASSWORD:-$(tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1)}

	echo "server=1" >> $CONF
	echo "rpcbind=0.0.0.0" >> $CONF
	echo "rpcallowip=0.0.0.0/0" >> $CONF
	echo "rpcuser=${RPC_USER}" >> $CONF
	echo "rpcpassword=${RPC_PASSWORD}" >> $CONF
fi;

echo "Initialization completed successfully"

set -ex
exec bvaultd -printtoconsole