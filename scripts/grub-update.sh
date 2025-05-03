#!/bin/sh
list=("hyperfluent-arch" "hyperfluent-debian" "hyperfluent-fedora" "hyperfluent-gentoo" "hyperfluent-linux-generic" "hyperfluent-manjaro" "hyperfluent-redhat" "hyperfluent-ubuntu")
random_distro=$(shuf -n 1 -e "${list[@]}")
sudo sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"/usr/share/grub/themes/$random_distro/theme.txt\"|" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
