docker run -it \
  --name windows \
  -e VERSION="11" \
  -p 8006:8006 \
  -p 3389:3389 \
  --device=/dev/kvm \
  --cap-add NET_ADMIN \
  --stop-timeout 120 \
  -e DISK_SIZE=60G \
  dockurr/windows
