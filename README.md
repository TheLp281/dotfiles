✨ TheLp's Hyprland Dotfiles ✨
✨ Forked from shub39 ✨
✨ Merged with EviLuci's Dotfiles ✨

Repo Size: ![Repo Size](https://img.shields.io/github/repo-size/shub39/dotfiles?color=CAC992&label=SIZE&logo=googledrive&style=for-the-badge&logoColor=D9E0EE&labelColor=292324)

Screenshots:
![Screenshot 1](screenshots/1.png)
![Screenshot 2](screenshots/2.png)
![Screenshot 3](screenshots/3.png)
![Screenshot 4](screenshots/4.png)

---

Required Packages:

These packages are essential for the system to function as expected:

- Hyprland: Wayland compositor
- Hyprpaper: Wallpaper setter for Hyprland
- Hyprpicker: Color picker for Hyprland
- Hyprlock: Lock screen for Hyprland
- Hypridle: Idle detection for Hyprland
- Kitty: Terminal emulator
- rofi-wayland: Application launcher
- Swaync: Wayland notifications daemon
- Waybar: Status bar for Wayland

Additionally, install these utilities for better functionality:

- fastfetch: System info fetcher
- imagemagick: Image manipulation tool
- mpv: Media player
- copyq: Clipboard manager
- polkit-gnome: PolicyKit agent for GNOME
- neovim: Text editor (with NVChad configuration)
- cava: Audio visualizer
- hyprshot: Screenshot tool for Hyprland
- Wlogout: Logout utility for Wayland

Install Command:

For Arch Linux or Arch-based distros, use the following command to install the required packages:

pacman -S hyprland hyprpaper hyprpicker hyprlock hypridle kitty rofi-wayland swaync waybar fastfetch imagemagick mpv copyq polkit-gnome neovim
yay -S neovim cava hyprshot wlogout

---

Optional Packages:

You may install the following packages for added functionality:

For Fish Shell:

- fish: User-friendly shell
- bat: Cat clone with syntax highlighting
- lolcat: Fun language translation
- reflector: A tool to find and use the best Arch mirrors
- lynx: Text-based web browser
- vifm: File manager with vi key bindings
- ncmpcpp: Music player client
- expac: Display Arch package information
- btrfs-progs: Utilities for Btrfs file system
- snapper: Snapshot manager for Btrfs

For additional tools, you can install:

- cpuid (AUR)
- moc (AUR) — A terminal-based music player

Spark Installation (for Fish shell):

To install Spark (a prompt enhancement for Fish shell), run:

sudo sh -c "curl https://raw.githubusercontent.com/holman/spark/master/spark -o /usr/local/sbin/spark && chmod +x /usr/local/sbin/spark"

For Music:

- cmus: Console music player

For Miku Cursor:

To use the Miku cursor theme:

1. Copy the hatsunemiku folder to /usr/share/icons:

   sudo cp -r ~/.config/dotfiles/hatsunemiku /usr/share/icons

2. Set the cursor theme in ~/.config/gtk-3.0/settings.ini:

   sed -i 's/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=hatsunemiku/' ~/.config/gtk-3.0/settings.ini

---

Quick Start:

Setup Instructions:

1. Install Required Packages:
   Run the commands mentioned above to install all the required packages.
   
2. Clone the Repository:
   Clone this repository into your ~/.config directory:

   git clone https://github.com/TheLp/dotfiles.git ~/.config

3. Configure Hyprland:
   Add the following line to your ~/.config/hypr/hyprland.conf file:

   echo "source = ~/.config/dotfiles/hyprland/hyprland.conf" > ~/.config/hypr/hyprland.conf

   Make sure to remove any other configurations in this file to avoid conflicts.

4. Configure Waybar:
   Copy the contents of the waybar folder into ~/.config/waybar:

   cp -r ~/.config/dotfiles/waybar/* ~/.config/waybar

5. Optional - Configure Fish Shell:
   If you're using Fish shell, copy the contents of the fish folder into ~/.config/fish:

   cp -r ~/.config/dotfiles/fish/* ~/.config/fish

6. Reboot:
   Reboot your system to apply the changes.

---

Customizations:

- Default Programs:
  Programs like browsers and media players are listed in hyprland/defaultPrograms.conf. Feel free to edit this file to suit your preferences.

- Keybindings:
  All keybindings are configured in hyprland/keybinds.conf. Modify this file to customize your key mappings.

---

Note: Explore the Hyprland wiki (https://wiki.hyprland.org/) for further documentation and customization tips.
