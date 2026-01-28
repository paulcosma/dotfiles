sudo pacman --noconfirm -S \
alacritty \
doublecmd-qt5 \
dnsutils \
helm \
intellij-idea-community-edition \
kdeconnect \
kmag \
krita \
kcalc \
kubectl \
remmina \
firefox firefox-developer-edition \
flameshot \
freerdp \
libreoffice-fresh \
mcfly \
meld \
nextcloud-client \
nfs-utils \
obs-studio \
pulseaudio pulseaudio-bluetooth \
python-pip \
tldr \
tmux \
thunderbird \
vlc \
wl-clipboard \
zsh zsh-completions

# Photos
sudo pacman --noconfirm -S \
gthumb ffmpegthumbnailer ffmpegthumbs gst-plugins-ugly gst-libav webp-pixbuf-loader
# gwenview dolphin ffmpegthumbs
# flameshot xdg-desktop-portal xdg-desktop-portal-wlr grim

# Change Shell to ZSH
chsh -s /usr/bin/zsh

# Pipewire setup
sudo pacman -S \
  pipewire \
  pipewire-pulse \
  pipewire-audio \
  pipewire-alsa \
  pipewire-jack \
  wireplumber \
  bluez \
  bluez-utils
sudo systemctl enable --now bluetooth.service
systemctl --user enable --now pipewire.socket
systemctl --user enable --now pipewire-pulse.socket
systemctl --user enable --now wireplumber.service
pactl info | grep "Server Name"
