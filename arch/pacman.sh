sudo pacman --noconfirm -S \
alacritty \
code \
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
freerdp \
flameshot \
libreoffice-fresh \
mcfly \
meld \
nextcloud-client \
nfs-utils \
obs-studio \
pulseaudio pulseaudio-bluetooth \
python-pip \
tmux \
tldr \
wl-clipboard \
zsh zsh-completions

# Photos
sudo pacman --noconfirm -S \
gthumb ffmpegthumbnailer ffmpegthumbs gst-plugins-ugly gst-libav
# gwenview dolphin ffmpegthumbs
# flameshot xdg-desktop-portal xdg-desktop-portal-wlr grim

# Change Shell to ZSH
chsh -s /usr/bin/zsh

# Deprecated
# pipewire wireplumber pipewire-pulse pipewire-audio \ # using pulseaudio for now
