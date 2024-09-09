# The first things to do

!!! warning
    This procedure is to be performed **ONLY** on MiniPC. On other platforms they are:

    * not necessary
    * perhaps useless
    * potentially **DANGEROUS**

All the following instructions are executed by the `root` user

``` sh
su
```

## Sudo and Sudoers

To add the user to the **sudoers** group, run the command

enter the root user password, then execute the following commands

``` sh
apt update && apt install sudo -y
nano /etc/sudoers
```

insert the following string at the bottom of the file

``` terminal
username ALL=(ALL) NOPASSWD:ALL
```

!!! info
    change `username` with the actual user name

exit saving ++ctrl+x+y+enter++

## Change to static IP addres

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

## Disable IPv6

``` sh
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p 
```

## System update

``` sh
apt update
apt full-upgrade -y
apt autoremove -y
```

## Reboot the system

Finally, perform a reboot with the command

``` sh
reboot
```
