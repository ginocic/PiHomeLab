if [ -f /usr/local/bin/pihole ]; then
  netdevs() {
    nmap -sP 172.18.12.* | grep report > /tmp/last
    read -p \'Connect new device then press ENTER\'
    nmap -sP 172.18.12.* | grep report > /tmp/now
    diff /tmp/last /tmp/now
  }

  phuprohi() {
    wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
  }
  
  alias phrepair="pihole -r"
  alias phstatus="pihole status"
  alias phresdns="pihole restartdns"
  alias phup="pihole -up"
  alias phchrono="pihole -c"
  alias phg="pihole -g"
  
  echo ""
  echo "        Pi-Hole : phstatus    | phchrono   | phresdns"
  echo "                  phup        | phg        | phrepair"
  echo "                  netdevs     | phuprohi"
  echo ""
fi
