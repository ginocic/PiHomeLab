# For all the linux hosts

## Disable IPv6

=== "Raspberry"

    Run the command

    ``` sh
    sudo nmtui
    ```

    select the following options

    - `Edit a connection`
    - `Wired connection 1`
    - `IPv6 CONFIGURATION`
        - set to `Disabled`
    - `OK`
    - `BACK`
    - `Quit`

=== "Odroid"

    [TDL]

=== "Zimaboard/Zimablade"

    [TDL]

=== "MiniPC"

    Run the command

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
