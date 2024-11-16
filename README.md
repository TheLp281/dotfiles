<div align="center">
    <h1>✨ TheLp's Hyprland dotfiles ✨</h1>
    <h1>✨ Forked from shub39 ✨</h1>
    <h1>✨ Merged with EviLuci's dotfiles ✨</h1>
</div>

<div align="center"> 

</a>
</div>

![1](screenshots/1.png)

![2](screenshots/2.png)

![3](screenshots/3.png)

![4](screenshots/4.png)

## Required Packages

- hyprland, hyprpaper, hyprpicker, hyprlock, hypridle
- kitty
- rofi-wayland
- swaync
- waybar
- fastfetch
- imagemagick
- pulseaudio
- pavucontrol
- mpv
- copyq
- polkit-gnome
- nwg-drawer
- neovim (AUR)
- cava (AUR)
- hyprshot (AUR)
- wlogout (AUR)

### Install Required Packages:
 ```bash
sudo pacman -S --needed hyprland hyprpaper hyprpicker hyprlock hypridle kitty rofi-wayland swaync waybar fastfetch imagemagick mpv copyq polkit-gnome nwg-drawer pulseaudio pavucontrol
 ```

```bash
yay -S cava hyprshot wlogout neovim
```

## Optional Packages
  ## For fish:
    sudo pacman -S --needed fish bat lolcat reflector lynx vifm ncmpcpp expac btrfs-progs snapper thefuck
    yay -S cpuid moc pokemon-colorscripts
    sudo sh -c "curl https://raw.githubusercontent.com/holman/spark/master/spark -o /usr/local/sbin/spark && chmod +x /usr/local/sbin/spark"
  ## For neovim:
    sudo pacman -S neovim
  ## For music
    sudo pacman -S cmus 
 

  ## For miku cursor
  - copy hatsunemiku folder into /usr/share/icons
      ```bash
      sudo cp -r ~/.config/dotfiles/hatsunemiku /usr/share/icons
      ```
  - in ~/.config/gtk-3.0/settings.ini set gtk-cursor-theme-name to hatsunemiku
      ```bash
      sed -i 's/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=hatsunemiku/' ~/.config/gtk-3.0/settings.ini
      ```
  

## Quick Start

- On fresh Hyprland, install all required packages and clone this repository at `~/.config`
    ```bash
    git clone https://github.com/TheLp281/dotfiles ~/.config
    ```
- Add `source = ~/.config/dotfiles/hyprland/hyprland.conf` to `~/.config/hypr/hyprland.conf` and remove everything else
    ```bash
     echo "source = ~/.config/dotfiles/hyprland/hyprland.conf" > ~/.config/hypr/hyprland.conf
     ```
- Copy waybar folder contents into ~/.config/waybar
  ```bash
  cp -r ~/.config/dotfiles/waybar ~/.config/waybar
  ```
- Copy fish folder contents into ~/.config/fish (optional)
  ```bash
  cp -r ~/.config/dotfiles/fish ~/.config/fish
  ```
- Reboot



> ### Other programs like browsers and players are listed in `hyprland/defaultPrograms.conf` edit accordingly
> ### All keybinds are listed at `hyprland/keybinds.conf` edit accordingly
> ### 🎉That’s all for now. Enjoy your new environment!🎉
