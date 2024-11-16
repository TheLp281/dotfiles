# ✨ TheLp's Hyprland dotfiles ✨  
### ✨ Forked from shub39 ✨  
### ✨ Merged with EviLuci's dotfiles ✨  

| Section                   | Content                                                                                                                                                                                              |
|---------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Badges**                 | ![](https://img.shields.io/github/repo-size/shub39/dotfiles?color=CAC992&label=SIZE&logo=googledrive&style=for-the-badge&logoColor=D9E0EE&labelColor=292324)                                      |
| **Screenshots**            | ![Screenshot 1](screenshots/1.png)  
![Screenshot 2](screenshots/2.png)  
![Screenshot 3](screenshots/3.png)  
![Screenshot 4](screenshots/4.png)                                                                                                                                                                   |
| **Required Packages**      | - Hyprland (Hyprpaper, Hyprpicker, Hyprlock, Hypridle)  
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
- Wlogout (AUR)                                                                                                                                                                                      |
| **Installation Commands**  | **With pacman:**  
`pacman -S hyprland hyprpaper hyprpicker hyprlock hypridle kitty rofi-wayland swaync waybar fastfetch imagemagick mpv copyq polkit-gnome neovim`  
**With yay (AUR):**  
`yay -S neovim cava hyprshot wlogout`                                                                                                                                                                |
| **Optional Packages**      | **For fish shell:**  
- fish, bat, lolcat, reflector, lynx, vifm, ncmpcpp, expac, btrfs-progs, snapper  
- cpuid (AUR), moc (AUR)  
**Spark Installation:**  
`sudo sh -c "curl https://raw.githubusercontent.com/holman/spark/master/spark -o /usr/local/sbin/spark && chmod +x /usr/local/sbin/spark"`  
**For music:**  
- cmus  
**For Miku Cursor:**  
- Copy the 'hatsunemiku' folder into `/usr/share/icons`:  
  `sudo cp -r ~/.config/dotfiles/hatsunemiku /usr/share/icons`  
- Set `gtk-cursor-theme-name` to `hatsunemiku` in `~/.config/gtk-3.0/settings.ini`:  
  `sed -i 's/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=hatsunemiku/' ~/.config/gtk-3.0/settings.ini` |
| **Config Files**           | - All keybinds are listed in `hyprland/keybinds.conf`. Edit it according to your preferences.  
- Other programs like browsers and media players are listed in `hyprland/defaultPrograms.conf`. Modify this file to fit your needs.  
- `hyprland/hyprland.conf` is the main config file for Hyprland.                                                                                       |
| **Quick Start**            | 1. Install required packages as mentioned above.  
2. Clone this repository to `~/.config`:  
   `git clone https://github.com/TheLp/dotfiles.git ~/.config`  
3. Add the following line to `~/.config/hypr/hyprland.conf` and remove all other contents:  
   `echo "source = ~/.config/dotfiles/hyprland/hyprland.conf" > ~/.config/hypr/hyprland.conf`  
4. Copy the `waybar` folder contents into `~/.config/waybar`.  
5. Copy the `fish` folder contents into `~/.config/fish` (optional).  
6. Reboot your system to apply the changes.                                                                                                                                                              |
| **Notes**                  | - All keybinds are listed in `hyprland/keybinds.conf`. Edit it according to your preferences.  
- Other programs like browsers and media players are listed in `hyprland/defaultPrograms.conf`. Modify this file to fit your needs.  
- Explore the [Hyprland wiki](https://github.com/hyprwm/Hyprland/wiki) for more information on configuration and features.                                                                                         |
