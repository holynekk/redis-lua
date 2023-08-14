
# General

ps -ef|grep redis

redis-cli --cluster create 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 127.0.0.1:7006 --cluster-replicas 1

redis-cli -c -p 700*

redis-cli --cluster check 127.0.0.1:7001

## How to check cluster health??

cluster nodes -> gives you node information

cluster slots

cluster help

cluster info

cluster myid

cluster keyslot k2 -> to find which key goes into which slot

cluster getkeysinslot 449 1 -> cluster getkeysinslot \<slot\> \<record_number\>

## Shutdown a Cluster

Shutdown saves first

redis-cli -p 700* shutdown
