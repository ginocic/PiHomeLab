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

!!! info
    Disconnect keyboard and monitor. Form now on, we will connect to the machine via SSH
