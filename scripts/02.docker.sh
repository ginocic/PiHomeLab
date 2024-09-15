if [ -f /usr/bin/docker ]; then
  dps() {
    local DPS_CMD="sudo docker ps --format \"table {{.Names}}}\t{{.State}}\t{{.RunningFor}}\t{{.Status}}\t{{.Image}}\""
    while (( "$#" )); do
      DPS_CMD="$DPS_CMD --filter name=$1"
      shift
    done
    bash -c "$DPS_CMD"
  }

  dnet() {
    local DNET_CMD="sudo docker ps --format \"table {{.Names}}\t{{.Ports}}\""
    while (( "$#" )); do
      DNET_CMD="$DNET_CMD --filter name=$1"
      shift
    done
    bash -c "$DNET_CMD"
  }

  alias dlogs='sudo docker logs -tf --tail="50" '
  alias dips="sudo docker ps -q | xargs -n 1 sudo docker inspect -f '{{.Name}}%tab%{{range .NetworkSettings.Networks}}{{.IPAddress}}%tab%{{end}}' | sed 's#%tab%#\t#g' | sed 's#/##g' | sort | column -t -N NAME,IP\(s\) -o $'\t'"
  alias ddelimages='sudo docker rmi $(sudo docker images -q)'
  alias dprunevol='sudo docker volume prune'
  alias dprunesys='sudo docker system prune -a'
  alias dprune='ddelimages ; dprunevol ; dprunesys'
  alias dstop='sudo docker stop $(sudo docker ps -a -q)'
  alias dstopall='sudo docker stop $(sudo docker ps -aq)'

  echo ""         Docker : dps     | dnet"
  echo "                   "
fi