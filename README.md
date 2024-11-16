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

- Hyprland, Hyprpaper, Hyprpicker, Hyprlock, Hypridle
- Kitty
- rofi-wayland
- Swaync
- Waybar

- fastfetch
- imagemagick
- mpv
- copyq
- polkit-gnome 
- neovim (nvchad - AUR)
- cava (AUR)
- hyprshot (AUR)
- Wlogout (AUR)

### Install Required Packages:
 ```bash
pacman -S hyprland hyprpaper hyprpicker hyprlock hypridle kitty rofi-wayland swaync waybar fastfetch imagemagick mpv copyq polkit-gnome neovim
 ```

```bash
yay -S cava hyprshot wlogout
```

## Optional Packages
  ## For fish:

       pacman -S fish bat lolcat reflector lynx vifm ncmpcpp expac btrfs-progs snapper
       yay -S cpuid moc
       sudo sh -c "curl https://raw.githubusercontent.com/holman/spark/master/spark -o /usr/local/sbin/spark && chmod +x /usr/local/sbin/spark"
  
  ## For music

    pacman -S cmus 
 

  ## For miku cursor (taken from supermariofps)
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
> ### Explore hyprland wiki and figure everything else on your own
