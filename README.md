# keepalived
docker file for keepalived base on centos7


### only support vrrp without lvs

-  build keepalived bin file without lvs
```
./configure --disable-lvs-syncd --disable-lvs --enable-snmp --enable-sha1
make
```

- need to run the container with --net=host --privileged

- note: it seems -f <config file> doesn't work. need to put the config file in the /etc/keepalived path

### another way to use the keepavlied with yum install, it will contain lvs feature

- need to load the ip_vs module in coreos kernel before run keepalived `sudo modprobe -a ip_vs`

- if forget the load the ip_vs, keepalived will make host systemd_coredump, and it will occupied cup very high
