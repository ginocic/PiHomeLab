# Networking settings

!!! info
    run the following commands as `root` user with the command

    ``` sh
    sudo su -
    ```

## Disable WiFi and/or Bluetooth

``` sh
nano /boot/firmware/config.txt
```

add the following to the end of the file

``` text
dtoverlay=disable-wifi
dtoverlay=disable-bt
```

save the file with ++ctrl+x+y+enter++ and execute the next command

## Change to static IP address and disable IPv6

Run the command

``` sh
nmtui
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

!!! warning
    Changing the IP address could break the connection. If so, connect again with the right address.
