# First configurations

Connect over SSH to set up the first configurations.

## Disable WiFi and/or Bluetooth

=== "Raspberry"

    ``` sh
    sudo nano /boot/firmware/config.txt
    ```

    add the following to the end of the file

    ``` text
    dtoverlay=disable-wifi
    dtoverlay=disable-bt
    ```

    save the file with ++ctrl+x+y++ and execute the next command

=== "Odroid"

    [TDL]

=== "Zimaboard/Zimablade"

    [TDL]

=== "MiniPC"

    [TDL]

## Change to static IP address and disable IPv6

=== "Raspberry"

    Run the command

    ``` sh
    sudo nmtui
    ```

    select the following options

    - `Edit a connection`
    - `Wired connection 1`
    - `IPv4 CONFIGURATION`
        - set to `Manual`
        - `Addresses` &rArr; `Add` &rArr; *static IP of the host*
        - `Gateway` &rArr; `Add` &rArr; *IP of the gateway*
        - `DNS server` &rArr; `Add` &rArr; *IP of the DNS*
        - `Search domains` &rArr; `Add` &rArr; *network domains*
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

    ``` sh
    sudo nano /etc/network/interfaces
    ````

!!! warning
    Changing the IP address could break the connection. If so, connect again with the right address.

## Reboot the host

Just to be sure that all the modification will be preserved, execute the next command to reboot the host

``` sh
sudo reboot
```

Log in again just to check that there are no errors.
