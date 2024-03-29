# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
for rc in ~/.bashrc.d/*; do
if [ -f "$rc" ]; then
. "$rc"
fi
done
fi
unset rc

#
# USER ALIASES
#
# Flatpak & DNF
alias dnfinst="sudo dnf install"
alias dnfrem="sudo dnf —setopt=tsflags=noscripts remove"
alias dnfind="dnf search"
alias dnfup="sudo dnf update"
alias flatinst="flatpak install flathub"
alias flatrem="flatpak remove —noninteractive -y"
alias flatfind="flatpak search"
alias up="sudo dnf upgrade —refresh —best —allowerasing -y && flatpak update -y"

# Git
alias ga="git add"
alias gc="git commit"
alias gpu="git push"
alias gpl="git pull"
alias gs="git status"
alias gl="git log"
alias gauth="gh auth setup-git"

#
# Default bash alias
#
alias new="clear && exec bash"
alias gte='gnome-text-editor'
alias sets='gnome-control-center'
alias conf='nano ~/.bashrc'
alias nvim="~/nvim.appimage"
alias ra="ranger"
alias c="cmatrix -sC cyan -u 3"
alias ff="fastfetch -s Title:Separator:OS:Host:Kernel:Uptime:Shell:Display:DE:WM:Terminal:CPU:GPU:Memory:Swap:Disk:Battery"

#
# apps
#
alias doom="flatpak run io.github.fabiangreffrath.Doom -iwad /home/coldousedbird/.var/app/io.github.fabiangreffrath.Doom/data/crispy-doom/autoload/DOOM.WAD"
alias hexen="flatpak run io.github.fabiangreffrath.Hexen -iwad /home/coldousedbird/.var/app/io.github.fabiangreffrath.Doom/data/crispy-doom/autoload/HEXDD.WAD"
#alias heretic="flatpak run io.github.fabiangreffrath.Doom -iwad /home/coldousedbird/.var/app/io.github.fabiangreffrath.Doom/data/crispy-doom/autoload/HERETIC.WAD"
#alias strife="flatpak run io.github.fabiangreffrath.Doom -iwad /home/coldousedbird/.var/app/io.github.fabiangreffrath.Doom/data/crispy-doom/autoload/STRIFE1.WAD"
#alias voices="flatpak run io.github.fabiangreffrath.Doom -iwad /home/coldousedbird/.var/app/io.github.fabiangreffrath.Doom/data/crispy-doom/autoload/VOICES.WAD"
#alias doom="flatpak run io.github.fabiangreffrath.Doom -iwad /home/coldousedbird/Games/PC/DOOM.WAD"

alias stalker="cd /home/coldousedbird/Games/PC/STALKER_OpenXRay_Linux/scop && ./start.sh"

### useful for now
alias scum="cd ~/Programming/scumkiller/build && cmake —build . && ./bin/scumkiller"
alias sludge_setup="cd ~/Programming/sludge/src && source ../sludge_venv/bin/activate"
alias sludge="python main.py"
alias filth_setup="cd ~/Programming/filth/src && source ../filth_venv/bin/activate"
alias filth="python main.py"

# Greetings!
ff
echo 'Yo, whatssup, '$USER'?'

