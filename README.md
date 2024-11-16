<div align="center">
    <h1>✨ TheLp's Hyprland dotfiles ✨</h1>
    <h1>✨ Forked from shub39 ✨</h1>
    <h1>✨ Merged with EviLuci's dotfiles ✨</h1>
</div>

<div align="center"> 

![](https://img.shields.io/github/repo-size/shub39/dotfiles?color=CAC992&label=SIZE&logo=googledrive&style=for-the-badge&logoColor=D9E0EE&labelColor=292324)

</a>
</div>

![1](screenshots/1.png)

![2](screenshots/2.png)

![3](screenshots/3.png)

![4](screenshots/4.png)

## Required Packages

- Hyprland, Hyprpaper, Hyprpicker, Hyprlock, Hypridle
- Kitty
- Rofi `rofi-wayland`
- Swaync
- Waybar
- Wlogout
- fastfetch and imagemagick
- mpv
- copyq
- wezterm
- polkit-gnome 
- neovim (nvchad)
- cava (AUR)
- hyprshot (AUR)

## Optional Packages

  ## For fish:
    fish bat lolcat reflector lynx vifm ncmpcpp expac btrfs-progs snapper
    cpuid (AUR) moc (AUR)

    Spark installation:
      sudo sh -c "curl https://raw.githubusercontent.com/holman/spark/master/spark -o /usr/local/sbin/spark && chmod +x /usr/local/sbin/spark"
  ## For music
    cmus
  ## For wezterm
    ttf-firacode-nerd

  ## For miku cursor (taken from supermariofps)
  - copy miku-cursor folder into /usr/share/icons
  - in ~/.config/gtk-3.0/settings.ini set gtk-cursor-theme-name to hatsunemiku

> ### Other programs like browsers and players are listed in `hyprland/defaultPrograms.conf` edit accordingly
> ### All keybinds are listed at `hyprland/keybinds.conf` edit accordingly
> ### Explore hyprland wiki and figure everything else on your own

## Quick Start

- On fresh Hyprland, install all the above packages and clone this repository at `~/.config`
- Add `source = ~/.config/dotfiles/hyprland/hyprland.conf` to `~/.config/hypr/hyprland.conf` and remove everything else
- Copy wezterm folder contents into ~/.config/wezterm
- Copy waybar folder contents into ~/.config/waybar
- Copy fish folder contents into ~/.config/fish
- Reboot
