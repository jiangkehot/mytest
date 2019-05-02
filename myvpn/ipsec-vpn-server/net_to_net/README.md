## branchOffice

```
docker run \
    --name ipsec-vpn-server \
    --env-file ./vpn.env \
    --restart=always \
    --network=host \
    -v /lib/modules:/lib/modules:ro \
    -v /usr/local/etc/ipsec.d:/etc/ipsec.d \
    -d --privileged \
    hwdsl2/ipsec-vpn-server  
docker exec ipsec-vpn-server wget https://raw.githubusercontent.com/jiangkehot/mytest/master/myvpn/ipsec-vpn-server/net_to_net/branchOffice/run.sh
docker restart ipsec-vpn-server
docker logs ipsec-vpn-server
```
