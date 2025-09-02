#!/bin/bash

echo "Nokx dot files configurer 0.0.1"
echo "verifying distro"
distro_id="$(cat /etc/*-release | grep "ID=")"
script_base="$(./distro_check $distro_id)"
nvim_install() { #all distro linux
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim # clean install (removable)
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz # extract
    sudo mv /opt/nvim-linux-x86_64 /opt/nvim
    sudo ln -s -f /opt/nvim/bin/nvim /bin/nvim
    sudo rm -rf nvim-linux-x86_64.tar.gz
    echo "configuring nvim"
    echo "copying packer neovim repo"
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim
}
sublime_text_3_install(){
    sudo curl -LO https://download.sublimetext.com/sublime_text_3_build_3211_x64.tar.bz2
    sudo rm -rf /opt/sublime_text_3
    sudo tar -C /opt -xvjf sublime_text_3_build_3211_x64.tar.bz2 # extract
    sudo ln -s -f /opt/sublime_text_3/sublime_text /bin/subl
    sudo rm -rf sublime_text_3_build_3211_x64.tar.bz2
}
# DEBIAN SCRIPT
if [[ "$script_base" = "debian" ]]; then
    echo "debian-based distro identified"
    mkdir $HOME/.config
    echo "updating"
    sudo apt update -y
    echo "upgrading"
    sudo apt upgrade -y
    sudo apt --fix-broken install
    sudo apt install build-essential
    echo "installing git"
    sudo apt-get install git
    echo "installing ripgrep"
    sudo apt-get install ripgrep
    echo "install curl"
    sudo apt-get install curl
    curl --version
    echo "installing zip & unzip tools"
    sudo apt install zip
    sudo apt install unzip
    sudo apt install tar
    sudo apt install dpkg
    echo "installing neovim"
    nvim_install
    
    echo "installing 
elif [[ "$script_base" = "arch" ]]; then
    echo "arch-based distro identified"
elif [[ "$script_base" = "invalid distro" ]]; then
    echo "invalid distro"
else
    echo "error"
fi

