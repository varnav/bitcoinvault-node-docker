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

#### Run interactively

```bash
docker run --rm -it -v bitcoinvault-db:/opt/bvault -e "RPC_SERVER=1" varnav/bitcoinvault-node
```

#### Run as daemon

```bash
docker run -d --restart=unless-stopped --name bitcoinvault -v bitcoinvault-db:/opt/bvault -e "RPC_SERVER=1" varnav/bitcoinvault-node
```

#### Clean all

```bash
docker rm --force bitcoinvault
docker volume rm bitcoinvault-db
docker image rm varnav/bitcoinvault-node
```

#### License

MIT
