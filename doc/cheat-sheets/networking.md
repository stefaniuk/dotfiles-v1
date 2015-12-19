#### Networking

/etc/network/interfaces

##### Dynamic IP

    iface eth0 inet dhcp

##### Static IP

    iface eth0 inet static
      address 192.168.1.100
      netmask 255.255.255.0
      gateway 192.168.1.1
      dns-nameservers 192.168.1.1
