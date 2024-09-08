# Operating system installation

## Requirements

### Hardware

=== "Raspberry"

    - USB to MicroSD adapter
    - MicroSD (&GreaterEqual;16Gb)

=== "Odroid"

    [TDL]

=== "Zimaboard/Zimablade"

    [TDL]

=== "MiniPC"

    - USB Stick (at least 8Gb)

!!! tip
    Connect a **keyboard** and **monitor** to the host to follow the initial installation phase and check that no errors occur.

### Software

=== "Raspberry"

    [Raspberry Pi Imager](https://www.raspberrypi.com/software/)

=== "Odroid"

    [TDL]

=== "Zimaboard/Zimablade"

    [TDL]

=== "MiniPC"

    [Balena Etcher](https://etcher.balena.io/)

## Writing OS image

Write the operating system to the proper device using the releated software. When it's done, take out the device.

Insert it into the host and turn it on.

The installation will start and, after a few minutes, it will finish waiting for the first user login.

## First Login

Log in and give the first command

=== "Raspberry"

    ```sh
    ip a show eth0
    ```

=== "Odroid"

    [TDL]

=== "Zimaboard/Zimablade"

    [TDL]

=== "MiniPC"

    ```sh
    ip a show eno1
    ```

Write down the IP address of the host.

!!! info
    Disconnect keyboard and monitor. Form now on, we will connect over SSH
