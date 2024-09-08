# Enabling the TRIM function

## Find the controller's USB address

!!! note
    This will be needed later

``` sh
lsusb
```

``` terminal  hl_lines="1"
Bus 002 Device 002: ID 174c:1153 ASMedia Technology Inc. ASM1153 SATA 3Gb/s bridge
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 2109:3431 VIA Labs, Inc. Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

!!! tip
    from which I get the controller's USB address: 174c:1153

## Enable TRIM

Check if the SSD has TRIM enabled

``` sh
lsblk --discard /dev/sda
```

If the DISC-GRAN and DISC-MAX parameters are 0, then TRIM is not enabled.

``` terminal
NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
sda           0         0        0         0
└─sda1        0         0        0         0
```

Create a file to add a rule to `udev` to enable TRIM for the SSD of that specific controller:

``` sh
sudo nano /etc/udev/rules.d/50-usb-ssd-trim.rules
```

add the following line taking care to replace the `idVendor` value with your value before the colon previously identified with `lsusb` and `idProduct` with your value after the colon.

``` terminal
ACTION=="add|change", ATTRS{idVendor}=="<idVendor>", ATTRS{idProduct}=="<idProduct>", SUBSYSTEM=="scsi_disk", ATTR{provisioning_mode}="unmap"
```

!!! example
    the controller USB address was **174c:1153** so after splitting at the colon:

    | Parameter | value |
    | :---------| :---: |
    | idVendor  | 174c  |
    | idProduct | 1153  |

    the line of code becomes:

    ``` terminal
    ACTION=="add|change", ATTRS{idVendor}=="174c", ATTRS{idProduct}=="1153", SUBSYSTEM=="scsi_disk", ATTR{provisioning_mode}="unmap"
    ```

Reboot the system and verify that TRIM support has been enabled for the controller

``` sh
lsblk --discard /dev/sda
```

If the values of `DISC-GRAN` and `DISC-MAX` are a number other than zero, then TRIM is enabled.

``` terminal
NAME   DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
sda           0      512B       4G         0
└─sda1        0      512B       4G         0
```

## Checking

First manual run to verify

``` sh
sudo fstrim -a -v
```

It should be something this

``` terminal
/boot: 29.7 GiB (31825018880 bytes) trimmed on /dev/mmcblk0p1
/: 217 GiB (233022255104 bytes) trimmed on /dev/sda1
```

## Conclusions

Enable and start the services

``` sh
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer
sudo systemctl start fstrim.service
```
