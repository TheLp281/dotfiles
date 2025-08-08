<div align="center">
    <h1>✨ TheLp's Hyprland dotfiles ✨</h1>
    <h1>✨ Forked from shub39 ✨</h1>
    <h1>✨ Merged with EviLuci's dotfiles ✨</h1>
</div>

<div align="center">

</a>
</div>

![1](screenshots/screenshot_2024-11-17_22-43-14.png)

![2](screenshots/screenshot_2024-11-17_22-48-25.png)

![3](screenshots/screenshot_2024-11-17_22-53-31.png)

![4](screenshots/2024-11-17-230108_hyprshot.png)

![5](screenshots/screenshot_2024-11-17_22-49-13.png)

## 🚀 Quick Start

- On fresh Hyprland, install all required packages and clone this repository at `~/.config`

  ```bash
  git clone --depth 1 https://github.com/TheLp281/dotfiles ~/.config
  ```

- Add `source = ~/.config/dotfiles/hyprland/hyprland.conf` to `~/.config/hypr/hyprland.conf` and remove everything else

  ```bash
   echo "source = ~/.config/dotfiles/hyprland/hyprland.conf" > ~/.config/hypr/hyprland.conf
  ```

- - Create a symbolic link of waybar config

```bash
ln -s ~/.config/dotfiles/waybar ~/.config/waybar
```

- - Add a wallpaper at ~/Pictures/Wallpapers.

I personally prefer cloning wallpaper bank

```bash
git clone --depth 1 https://github.com/JaKooLit/Wallpaper-Bank ~/Pictures/Wallpapers
```

- Install packages below and relogin

# Required Packages

- hyprland, hyprpicker, hyprlock, hypridle
- kitty
- rofi-wayland
- swaync
- waybar
- noto-fonts-emoji
- fastfetch
- imagemagick
- pavucontrol
- mpv
- copyq
- polkit-gnome
- mpd-mpris
- polkit-kde-agent
- zenity
- swww (AUR)
- neovim (AUR)
- hyprshot (AUR)
- wlogout (AUR)
- ttf-firacode-nerd (AUR)

### Install Required Packages

```bash
sudo pacman -S --needed --noconfirm hyprland hyprpicker hyprlock hypridle kitty rofi-wayland swaync waybar noto-fonts-emoji fastfetch imagemagick mpv copyq polkit-gnome pavucontrol polkit-kde-agent zenity
```

```bash
yay -S hyprshot wlogout swww ttf-firacode-nerd --noconfirm
```

# Optional Packages
## For start menu on Super + A
  Setup https://github.com/adi1090x/rofi
  ```bash
  git clone https://github.com/adi1090x/rofi
  bash setup.sh
  ```
## For battery events notify service
  Create a symbolic link to battery events service
  ```bash
  mkdir -p ~/.config/systemd/user
  ln -s ~/.config/dotfiles/systemd/user/battery-events.service ~/.config/systemd/user/battery-events.service
  systemctl --user enable --now battery-events.service
  ```

## For fish

    sudo pacman -S --needed --noconfirm fish bat lolcat reflector lynx vifm ncmpcpp expac btrfs-progs snapper thefuck starship
    yay -S cpuid moc pokemon-colorscripts
    sudo sh -c "curl https://raw.githubusercontent.com/holman/spark/master/spark -o /usr/local/sbin/spark && chmod +x /usr/local/sbin/spark"

## For neovim

    yay -S neovim-git vscode-js-debug --noconfirm
    sudo pacman -S python-debugpy --noconfirm
    ln -s ~/.config/dotfiles/nvim ~/.config/nvim

## For music

    sudo pacman -S --noconfirm mpd-mpris

## For miku cursor

- copy hatsunemiku folder into /usr/share/icons

  ```bash
  sudo cp -r ~/.config/dotfiles/hatsunemiku /usr/share/icons
  ```

- in ~/.config/gtk-3.0/settings.ini set gtk-cursor-theme-name to hatsunemiku

  ```bash
  sed -i 's/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=hatsunemiku/' ~/.config/gtk-3.0/settings.ini
  ```

## For copyq theme

- Open the CopyQ main window
- Open CopyQ Preferences under the File > Preferences menu
- Click Appearance in the Configuration window
- Click Load Theme and select theme.ini

## For candy icons

- Copy candy folder into /usr/share/icons

```bash
sudo cp -r ~/.config/dotfiles/candy /usr/share/icons
```

- Set icon theme

```bash
gsettings set org.gnome.desktop.interface icon-theme 'candy-icon'
```

## For notification center

- Create a symbolic link of swaync config
- ln -s ~/.config/dotfiles/swaync ~/.config/swaync

## For fish shell

- Create a symbolic link of fish config

```bash
ln -s ~/.config/dotfiles/fish ~/.config/fish
```

> ### Other programs like browsers and players are listed in `hyprland/defaultPrograms.conf`
>
> ### All keybinds are listed at `hyprland/keybinds.conf`

### 🎉That’s all for now. Enjoy your new environment!🎉
