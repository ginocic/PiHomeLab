# For all the linux hosts

!!! note
    run the following commands as `root` user with the command

    ``` sh
    sudo su -
    ```

## System update

``` sh
apt update
apt full-upgrade -y
apt autoremove -y
```

## Suggested packages

``` sh
apt install -y rsync git curl wget tmux parted
```

## Bash Aliases

``` sh
for sh in 01.system 02.docker 03.pihole 04.pialert 05.omv; do sudo wget -N -P /etc/profile.d https://raw.githubusercontent.com/ginocic/PiHomeLab/main/scripts/$sh.sh; done
```

Test your work. Do NOT log-out of existing terminal session. Instead, open a new terminal session (Duplicate session).

## Reboot the system

Finally, perform a reboot with the command

``` sh
reboot
```
