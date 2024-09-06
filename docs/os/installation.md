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

Log in and give the first command

```sh
ip a show eth0
```

write down the IP address of the Raspberry

```sh
sudo nano /boot/firmware/config.txt
```

add the following to the end of the file

```text
dtoverlay=disable-wifi
dtoverlay=disable-bt
```

save the file with ++ctrl+x+y++ and execute the next command

```sh
sudo nano /boot/firmware/cmdline.txt
```

add the following to the end of the file

```text
 ipv6.disable=1
```

!!! note
    do not forget the space before the text

again, save the file with ++ctrl+x+y++ and execute the next command to reboot the Raspberry

```sh
sudo reboot
```
