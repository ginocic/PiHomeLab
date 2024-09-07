# First configurations

## Disable WiFi and/or Bluetooth

```sh
sudo nano /boot/firmware/config.txt
```

add the following to the end of the file

```text
dtoverlay=disable-wifi
dtoverlay=disable-bt
```

save the file with ++ctrl+x+y++ and execute the next command

## Change to static IP address and disable IPv6

```sh
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

The first configurations are ended. Execute the next command to reboot the Raspberry

```sh
sudo reboot
```

Log in again just to check that there are no errors.