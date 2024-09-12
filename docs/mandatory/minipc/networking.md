# Networking settings

!!! info
    run the following commands as `root` user with the command

    ``` sh
    sudo su -
    ```

## Change to static IP address

``` sh
nano /etc/network/interfaces
```

comment out the line

``` terminal hl_lines="5"
iface lo inet loopback

# The primary network interface
allow-hotplug enp1s0
#iface enp1s0 inet dhcp
```

add static settings just after that line

``` terminal hl_lines="2 4 6 8 10 12 14"
# add static settings
iface enp1s0 inet static
# IP address
address 10.0.0.30
# network address
network 10.0.0.0
# subnet mask
netmask 255.255.255.0
# broadcast address
broadcast 10.0.0.255
# default gateway
gateway 10.0.0.1
# name server
dns-nameservers 10.0.0.10
```

!!! note
    obviously, change the addresses with the correct ones

exit saving ++ctrl+x+y+enter++

``` sh
systemctl restart ifup@enp1s0
```

For nameservers, if

- resolvconf or Networkmanager programs have not been installed
- installed OS with only [Standard system utilties]

then it needs to edit `/etc/resolv.conf` by hand

``` sh
nano /etc/resolv.conf
```

to set domainame and nameserver

``` terminal
domain example.com
search example.com
nameserver 10.0.0.10
```

exit saving ++ctrl+x+y+enter++

!!! warning
    Changing the IP address could break the connection. If so, connect again with the right address.

## Disable IPv6

Run the command

``` sh
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p 
```
