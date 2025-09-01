#!/bin/bash

echo "Nokx dot files configurer 0.0.1"
echo "verifying distro"
distro_id="$(cat /etc/*-release | grep "ID=")"
script_base="$(./distro_check $distro_id)"
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
    :'
    echo "installing nvim"
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    chmod u+x nvim-linux-x86_64.appimage
    sudo ./nvim-linux-x86_64.appimage
    rm ./nvim-linux-x86_64.appimage
    mkdir -p /opt/nvim
    mv nvim-linux-x86_64.appimage /opt/nvim/nvim
    chmod u+x /opt/nvim/nvim
    sudo ln -s -f /opt/nvim/nvim -t /bin/nvim
    echo "copying packer neovim repo"
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    '
    
elif [[ "$script_base" = "arch" ]]; then
    echo "arch-based distro identified"
elif [[ "$script_base" = "invalid distro" ]]; then
    echo "invalid distro"
else
    echo "error"
fi

