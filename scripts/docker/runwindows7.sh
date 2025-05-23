docker run -it \
  --name windows \
  -e VERSION="11" \
  -p 8006:8006 \
  -p 3389:3389 \
  --device=/dev/kvm \
  --cap-add NET_ADMIN \
  --stop-timeout 20 \
  -e DISK_SIZE=20G \
  dockurr/windows
