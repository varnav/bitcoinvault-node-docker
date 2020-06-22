# Bitcoin Vault Node

https://bitcoinvault.global/

https://github.com/bitcoinvault/bitcoinvault

#### Build

It's recommended to build this on same machine where you plan to run it.

```bash
git clone https://github.com/varnav/bitcoinvault-node-docker.git
cd bitcoinvault-node-docker
docker build -t varnav/bitcoinvault-node .
```

#### RPCauth parameter

Use [this script](https://raw.githubusercontent.com/bitcoin/bitcoin/master/share/rpcauth/rpcauth.py) to generate password.

#### Run interactively

```bash
docker run --rm -it -v bitcoinvault-db:/opt/bvault varnav/bitcoinvault-node
```

#### Run as daemon

Will bind RPC to port 38332

```bash
docker run -d --restart=unless-stopped --name bitcoinvault -p 48332:48332 -v bitcoinvault-db:/opt/bvault varnav/bitcoinvault-node -rpcallowip='10.0.0.0/8' -rpcbind='0.0.0.0:48332' -rpcauth='admin:ea8ab83e1ec635249a3aa8d8285f1581$d57b887e0a7e71bd205fc5d5cdf51844206389ce6a66e3fe502702a87beb5b97'
```

#### Test RPC

curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getnetworkinfo","params":[]}' http://foo:qDDZdeQ5vw9XXFeVnXT4PZ--tGN2xNjjR4nrtyszZx0=@127.0.0.1:38332/

#### Clean all

```bash
docker rm --force bitcoinvault
docker volume rm bitcoinvault-db
docker image rm varnav/bitcoinvault-node
```

#### License

MIT
