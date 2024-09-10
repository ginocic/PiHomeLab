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

!!! warning
    Changing the IP address could break the connection. If so, connect again with the right address.

## Reboot the host

Just to be sure that all the modification will be preserved, execute the next command to reboot the host

    ``` sh
    sudo reboot
    ```

Log in again just to check that there are no errors.
