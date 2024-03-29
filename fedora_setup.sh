#!/bin/bash
cd ~
# greetings
echo ""
echo "yo, setup linux again?"
echo "let's go."

# update
echo ""
echo "--- upgrading dnf..."
sudo dnf upgrade --refresh --best --allowerasing -y
echo "--- upgrading flatpak..."
flatpak update -y
echo "--- clearing shit..."
sudo dnf autoremove
sudo dnf clean all 
flatpak uninstall --unused -y

# adding repos
echo ""
echo "--- adding flathub repo..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo "--- adding RPM Fusion repo..."
sudo dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# setup
# remove preinstalled libreoffice
if rpm -q libreoffice 1>/dev/null; then
echo ""
read -p "libreOffice is installed locally. delete this shit with dependencies? (y/n) " uninstall
if [ "$uninstall" == "y" ]; then
echo "--- removing libreofice..."
sudo dnf remove libreoffice*
fi
fi

# onlyoffice
echo ""
echo "--- installing onlyoffice..."
flatpak install --noninteractive -y flathub org.onlyoffice.desktopeditors

# firefox
echo ""
read -p ">>> do u have firefox already? (y/n) " choice
if [ "$choice" == "n" ]; then
echo "--- installing firefox..."
sudo dnf install firefox
fi

# telegram
echo "--- installing telegram..."
flatpak install flathub org.telegram.desktop
sudo flatpak override --env=XCURSOR_SIZE=12 org.telegram.desktop
flatpak --user override --filesystem=/home/$USER/.icons/:ro org.telegram.desktop
flatpak --user override --filesystem=/usr/share/icons/:ro org.telegram.desktop

# transmission (torrent)
echo "--- installing torrent client..."
flatpak install --noninteractive flathub com.transmissionbt.Transmission -y

# krita
echo "--- installing krita..."
flatpak install --noninteractive -y flathub org.kde.krita

# foliate
echo "--- installing ebook-reader..."
flatpak install --noninteractive flathub com.github.johnfactotum.Foliate

# tweakers
printf "\n--- installing tweakers..."
sudo dnf install -y gnome-tweaks gnome-kra-ora-thumbnailer
flatpak install --noninteractive -y flathub com.github.tchx84.Flatseal 
flatpak install --noninteractive -y flathub com.mattjakeman.ExtensionManager

# terminal
printf "\n--- installing terminal stuff..."
printf "\n--- ..."
sudo dnf install -y htop fastfetch powerline-fonts cmatrix ranger

# synth-shell
printf "\n---installing synth-shell..."
git clone --recursive https://github.com/andresgongora/synth-shell.git
cd synth-shell
./setup.sh

# codecs
printf "\n--- installing codecs..."
flatpak install --noninteractive -y flathub io.mpv.Mpv
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y



