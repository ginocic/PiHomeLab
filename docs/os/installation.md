# Operating system installation

## Requirements

**Hardware**:

- USB to MicroSD adapter
- MicroSD (&GreaterEqual;16Gb)

**Software**: [Raspberry Pi Imager](https://www.raspberrypi.com/software/)

## Writing OS image to SD

Write the operating system to the MicroSD using Imager. When it's done, take out the MicroSD.

!!! tip "Some useful steps before proceeding"
    Connect a keyboard and monitor to the Raspberry to follow the initial installation phase and check that no errors occur.

Insert it into the Raspberry and turn it on.

The installation will start and, after a few minutes, it will finish waiting for the first user login.

## First Configurations

Log in and give the first command

```sh
ip a show eth0
```

to write down the IP address of the Raspberry

To disable WiFi and/or Bluetooth

```sh
sudo nano /boot/firmware/config.txt
```

add the following to the end of the file

```text
dtoverlay=disable-wifi
dtoverlay=disable-bt
```

save the file with ++ctrl+x+y++ and execute the next command

To change to static IP address and disable IPv6:

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

!!! info
    Disconnect keyboard and monitor. Form now on, we will connect to the machine via SSH
