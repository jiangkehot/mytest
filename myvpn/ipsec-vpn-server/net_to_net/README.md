## branchOffice

```
sudo modprobe af_key
# 开机加载内核模块 af_key
cat > /etc/modules-load.d/af_key.conf << EOF 
# Load af_key at boot af_key 
af_key
EOF

cd /usr/local/etc/ && curl -O https://raw.githubusercontent.com/jiangkehot/mytest/master/myvpn/ipsec-vpn-server/vpn.env

docker run \
    --name ipsec-vpn-server \
    --env-file ./vpn.env \
    --restart=always \
    --network=host \
    -v /lib/modules:/lib/modules:ro \
    -v /usr/local/etc/ipsec.d:/etc/ipsec.d \
    -d --privileged \
    hwdsl2/ipsec-vpn-server  

# -O filename 可以强制覆盖，不加则下载后重命名为run.sh.1 balabalabala...
docker exec ipsec-vpn-server wget https://raw.githubusercontent.com/jiangkehot/mytest/master/myvpn/ipsec-vpn-server/net_to_net/branchOffice/run.sh -O run.sh 
docker exec ipsec-vpn-server chmod +x run.sh
docker restart ipsec-vpn-server
docker logs ipsec-vpn-server
```
