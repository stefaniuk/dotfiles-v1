## Configuration

To make it persistent across reboots, you have to add it to
`/etc/sysconfig/network-scripts/route-<interface-file>` 

## Commands

    route add default gw 192.168.1.1
    route add -net 172.17.32.0 netmask 255.255.255.0 reject
    route add -net 172.17.64.0 netmask 255.255.255.0 gw 192.168.1.1
