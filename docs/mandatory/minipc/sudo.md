# Sudo and Sudoers

To add the user to the **sudoers** group, run the command

``` sh
su
```

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
