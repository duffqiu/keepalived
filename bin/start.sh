#!/bin/bash

set -e

echo "start keepalived with parameter : $@ "

if [[ -z "$2" ]] ;then
  echo "need more parameters"	
  exit 1
fi

case $1 in
  -vip=*|--virtualip=*)
  VIP="${1#*=}"
  ;;
  *)
  
  # unknown option
  echo "need route parameter"
  exit 2
  ;;
esac

# describe virtual service ip

cat>/etc/keepalived/keepalived.conf<<EOF
# Global Configuration

vrrp_sync_group VG1 {
   group {
      VI_1
   }
}

vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass dfsi887
    }
    virtual_ipaddress {
        ${VIP}
    }
}
EOF

/opt/bin/keepalived -C -P -l


