#!/bin/bash
cd ~
# greetings
printf "\n\n  yo, setup fedora again?\n  go, drink some tea and chill for a while.\n  this will spent some time. but don't go too far from here, maybe your password will be needed not single time."

# making dnf faster
dnf_modification="max_parallel_downloads=10
defaultyes=True
keepcache=True"
echo "$dnf_modification" | sudo tee -a /etc/dnf/dnf.conf > /dev/null
sudo dnf install dnf-automatic
sudo systemctl enable dnf-automatic.timer
printf "\n  DNF was made faster (probably, at least i tried...)"

# update
printf "\n--- upgrading dnf...\n"
sudo dnf upgrade --refresh --best --allowerasing -y
printf "\n--- upgrading flatpak...\n"
flatpak update -y
printf "\n--- clearing shit...\n"
sudo dnf autoremove
sudo dnf clean all 
flatpak uninstall --unused -y

# adding repos
printf "\n--- adding flathub repo...\n"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
printf "\n--- adding RPM Fusion repo...\n"
sudo dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# setup
# remove preinstalled libreoffice
if rpm -q libreoffice 1>/dev/null; then
  printf "\n  libreOffice is installed locally.\n  delete this shit with dependencies? (y/n) >>>"
  read uninstallFlag
  if [ "$uninstallFlag" == "y" ]; then
    printf "\n--- removing libreofice...\n"
    sudo dnf remove libreoffice*
  fi
fi

# onlyoffice
printf "\n--- installing onlyoffice...\n"
flatpak install --noninteractive -y flathub org.onlyoffice.desktopeditors

# firefox
printf "\n  do u have firefox already? (y/n) >>>"
read firefoxExists
if [ "$firefoxExists" == "n" ]; then
  printf "\n--- installing firefox...\n"
  sudo dnf install firefox
fi

# telegram
printf "\n--- installing telegram...\n"
flatpak install --noninteractive -y flathub org.telegram.desktop
sudo flatpak override --env=XCURSOR_SIZE=12 org.telegram.desktop
flatpak --user override --filesystem=/home/$USER/.icons/:ro org.telegram.desktop
flatpak --user override --filesystem=/usr/share/icons/:ro org.telegram.desktop

# vs code
printf "\n--- installing vs code...\n"
flatpak install --noninteractive -y com.visualstudio.code
# flatpak install com.visualstudio.code-oss
# flatpak install com.visualstudio.code-oss
# flatpak install flathub com.vscodium.codium

# github console tool
printf "\n--- installing github console tool...\n"
sudo dnf install gh

# transmission (torrent)
printf "\n--- installing torrent client...\n"
flatpak install --noninteractive -y flathub com.transmissionbt.Transmission

# krita
printf "\n--- installing krita...\n"
flatpak install --noninteractive -y flathub org.kde.krita

# foliate
printf "\n--- installing ebook-reader...\n"
flatpak install --noninteractive flathub com.github.johnfactotum.Foliate

# tweakers
printf "\n--- installing tweakers...\n"
sudo dnf install -y gnome-tweaks gnome-kra-ora-thumbnailer
# flatpak install --noninteractive -y flathub com.github.tchx84.Flatseal ????
flatpak install --noninteractive -y flathub com.mattjakeman.ExtensionManager

# terminal
printf "\n--- installing terminal stuff...\n"
sudo dnf install -y htop fastfetch powerline-fonts cmatrix ranger

# synth-shell
printf "\n---making terminal beautiful...\n"
git clone --recursive https://github.com/andresgongora/synth-shell.git
cd synth-shell
./setup.sh
rm -rf synth-shell

# codecs
printf "\n--- installing codecs...\n"
flatpak install --noninteractive -y flathub io.mpv.Mpv
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y

# reducing pause after bash: command not found
file_path="/etc/PackageKit/CommandNotFound.conf"
if [ -f "$file_path" ]; then
    sudo sed -i '/^SoftwareSourceSearch=/s/true/false/' "$file_path"
    printf "\n  Pause after 'bash: command not found...' is removed.\n"
fi
