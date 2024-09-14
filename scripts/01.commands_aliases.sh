# Print the IP address
_IP=$(ip -o route get 1 | sed 's/^.*src \([^ ]*\).*$/\1/;q') || true
_HOST=$(hostname) || true
if [ "$_IP" ]; then
  printf "\n\nCiao. Mi chiamo %s e mi trovi a questo indirizzo %s\n\n" "$_HOST" "$_IP"
fi

echo "Alias disponibili"
echo ""

# Package Manager
alias install='sudo apt install'
alias uninstall='sudo apt remove'
alias search='sudo apt-cache search'
alias upd='sudo apt update'
alias upg='sudo apt full-upgrade -y'
alias ripulisci='sudo apt autoremove -y'
alias aggiorna='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'
echo "  Aggiornamenti : install    | uninstall  | search"
echo "                  upd        | upg        | ripulisci"
echo "                                            aggiorna"
echo ""

# System
rsmv () {
  if [[ $# -eq 0 ]] ; then
    echo "No input files"
  else
    rsync -aP --remove-source-files "$@" && rm -rf "${@:1:$#-1}"
  fi
}

mkcd () {
  mkdir -p -- "$1" && cd -P -- "$1"
}

alias path='echo -e ${PATH//:/\\n}'
alias riavvia='sudo reboot'
alias spegni='sudo shutdown -h now'

echo "        Sistema : rsmv       | mkcd       | mount"
echo "                                riavvia   | spegni"
echo ""

# NAVIGATION
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'

echo "    Navigazione : ..         | .2         | .3"
echo ""

# FILE SIZE AND STORAGE
alias l='ls -lAh'
alias lsdisk='lsblk -p | grep "disk\|part"'
alias partuuid='sudo blkid -s PARTUUID'
alias mnt='mount | column -t'
alias mntdev='mount | grep -E ^/dev | column -t'
alias partusage='df -hlT --exclude-type=tmpfs --exclude-type=devtmpf'

echo "        Dischi  : ls         | mnt        | mntdev"
echo "                  lsdisk     | partuuid   | partusage"
echo ""

# SYSTEMD START, STOP AND RESTART
alias ctlreload='sudo systemctl daemon-reload'
alias ctlstart='sudo systemctl start'
alias ctlstop='sudo systemctl stop'
alias ctlrestart='sudo systemctl restart'
alias ctlstatus='sudo systemctl status'
alias ctlenable='sudo systemctl enable'
alias ctldisable='sudo systemctl disable'
alias ctlactive='sudo systemctl is-active'

echo "        Systemd : ctlstart   | ctlstop    | ctlstatus"
echo "                  ctlrestart | ctlreload "
echo "                  ctlenable  | ctldisable | ctlactive"
echo ""

# NETWORKING
alias ports='netstat -tulanp'
alias portsused='sudo netstat -tulpn | grep LISTEN'
alias ping='ping -c 4'

echo "           Rete : ping       | ports        | portsused"
echo ""

# FSTRIM
alias trimma='sudo fstrim -a -v'
alias trimtimer='sudo systemctl status fstrim.timer'
alias trimservice='sudo systemctl status fstrim.service'

echo "         FSTRIM : trimma   | trimtimer  | trimservice"
echo ""
