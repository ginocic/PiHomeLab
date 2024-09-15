# Pi-hole

!!! quote "from the website"
    The [Pi-hole(c)](https://pi-hole.net/) is a DNS sinkhole that protects your devices from unwanted content, without installing any client-side software.

## Prerequisites

### Firewalls

#### IPTables

**IPTables** uses two sets of tables. One set is for `IPv4` chains, and the second is for `IPv6` chains. If only `IPv4` blocking is used for the Pi-hole installation, only apply the rules for **IP4Tables**. Full Stack (`IPv4` and `IPv6`) require both sets of rules to be applied.

!!! note
    These examples insert the rules at the front of the chain. Please see your distribution's documentation for the exact proper command to use.

IPTables (IPv4)

``` sh
iptables -I INPUT 1 -s 172.66.28.0/24 -p tcp -m tcp --dport 80 -j ACCEPT
iptables -I INPUT 1 -s 127.0.0.0/8 -p tcp -m tcp --dport 53 -j ACCEPT
iptables -I INPUT 1 -s 127.0.0.0/8 -p udp -m udp --dport 53 -j ACCEPT
iptables -I INPUT 1 -s 172.66.28.0/24 -p tcp -m tcp --dport 53 -j ACCEPT
iptables -I INPUT 1 -s 172.66.28.0/24 -p udp -m udp --dport 53 -j ACCEPT
iptables -I INPUT 1 -p udp --dport 67:68 --sport 67:68 -j ACCEPT
iptables -I INPUT 1 -p tcp -m tcp --dport 4711 -i lo -j ACCEPT
iptables -I INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
```

IP6Tables (IPv6)

``` sh
ip6tables -I INPUT -p udp -m udp --sport 546:547 --dport 546:547 -j ACCEPT
ip6tables -I INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
```

## Installation

### One-Step Automated Install

``` sh
curl -sSL https://install.pi-hole.net | bash
```

## Post-Install

### Making your network take advantage of Pi-hole¶

Once the installer has been run, you will need to configure your router to have DHCP clients use Pi-hole as their DNS server which ensures all devices connected to your network will have content blocked without any further intervention.

If your router does not support setting the DNS server, you can use Pi-hole's built-in DHCP server; just be sure to disable DHCP on your router first (if it has that feature available).

As a last resort, you can manually set each device to use Pi-hole as its DNS server.

### Making your Pi-hole host use Pi-hole¶

Pi-hole will not be used by the host automatically after installation. To have the host resolve through Pi-hole and your configured blocking lists, you can make the host use Pi-hole as upstream DNS server:

!!! Warning
    If your Pi-hole host is using Pi-hole as upstream DNS server and Pi-hole fails, your host loses DNS resolution. This can prevent successful repair attempts, e.g. by pihole -r as it needs a working internet connection.

If your OS uses `dhcpcd` for network configuration, you can add to your `/etc/dhcpcd.conf`

``` sh
static domain_name_servers=127.0.0.1
```

## Updating

Updating is as simple as running the following command:

``` sh
pihole -up
```

### Some customization

``` sh
sudo wget -N -P /etc/profile.d https://raw.githubusercontent.com/ginocic/PiHomeLab/main/scripts/03.pihole.sh
```

## Pi-hole can be uninstalled using

``` sh
pihole uninstall
```

!!! warning
    If you are unsure whether a package should be removed during uninstalling, we'd recommend leaving it installed, as required system packages may be among them!
