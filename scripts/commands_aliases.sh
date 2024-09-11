# Print the IP address
_IP=$(ip -o route get 1 | sed 's/^.*src \([^ ]*\).*$/\1/;q') || true
_HOST=$(hostname) || true
if [ "$_IP" ]; then
  printf "\n\nCiao. Mi chiamo %s e mi trovi a questo indirizzo %s\n\n" "$_HOST" "$_IP"
fi

echo "Alias disponibili"
echo ""

# Package Manager
alias upd='sudo apt update'
alias upg='sudo apt full-upgrade -y'
alias ripulisci='sudo apt autoremove -y'
alias aggiorna='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'
echo "  Aggiornamenti : upd      | upg       | ripulisci"
echo "                                         aggiorna"
echo ""

# System
alias l='ls -lAh'
alias lsdisk='lsblk -p | grep "disk\|part"'

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

alias mount='mount |column -t'
alias path='echo -e ${PATH//:/\\n}'
alias ports='netstat -tulanp'


alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'

alias riavvia='sudo reboot'
alias spegni='sudo shutdown -h now'

echo "        Sistema : l        | lsdisk"
echo "                  rsmv     | mkcd"
echo "                  mount    | path      | ports"
echo "                  ..       | .2        | .3"
echo "                  riavvia  | spegni"
echo ""
