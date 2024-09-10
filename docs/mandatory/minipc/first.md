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

## Disable IPv6

``` sh
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p 
```
