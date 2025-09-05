#!/bin/bash
# check distro
echo "Nokx dot files configurer 0.0.1"
echo "verifying distro"
distro_id="$(cat /etc/*-release | grep "ID=")"
script_base="$(./distro_check $distro_id)"
nvim_install() { #generic linux install
    echo "installing neovim"
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
sublime_text_3_install(){ #generic linux install
    echo "installing sublime-text-3"
    sudo curl -LO https://download.sublimetext.com/sublime_text_3_build_3211_x64.tar.bz2
    sudo rm -rf /opt/sublime_text_3 # clean install (removable)
    sudo tar -C /opt -xvjf sublime_text_3_build_3211_x64.tar.bz2 # extract with bz2 flag
    sudo ln -s -f /opt/sublime_text_3/sublime_text /bin/subl
    sudo rm -rf sublime_text_3_build_3211_x64.tar.bz2
}
sublime_config_folder(){ # all distros
    echo "Configuring sublime"
    local dotfiles_path="$(pwd)"
    local my_config_sublime="${dotfiles_path}/sublime-text-3"
    local sublime_config_path="$HOME/.config/sublime-text-3"
    echo "configuring sublime text 3 .config folder"
    rm -rf $HOME/.config/sublime-text-3/Installed\ Packages
    rm -rf $HOME/.config/sublime-text-3/Packages
    echo "clean installation"
    local my_subl_packages="${my_config_sublime}/Packages"
    local my_subl_instld_packages="${my_config_sublime}/Installed Packages"
    ln -s "${my_subl_packages}" "${sublime_config_path}"
    ln -s "${my_subl_instld_packages}" "${sublime_config_path}"
}
nvim_config_folder(){ 
    local dotfiles_path="$(pwd)"
    local my_config_nvim="${dotfiles_path}/nvim"
    echo "configuring nvim .config folder"
    rm -rf "$HOME/.config/nvim"
    echo "clean installation"
    ln -s -f "${my_config_nvim}" "$HOME/.config/"
}
tmux_config(){
    local dotfiles_path="$(pwd)"
    local my_config_tmux="${dotfiles_path}/tmux"
    echo "configuring tmux .config file"
    rm -rf "$HOME/.tmux.conf"
    ln -s -f "${my_config_tmux}/.tmux.conf" "$HOME/"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}
alacritty_config(){
	local dotfiles_path="$(pwd)"
	local my_config_alacritty="${dotfiles_path}/alacritty"
	echo "configuring alacritty .config folder"
	rm -rf "$HOME/.config/alacritty" # clean install
	ln -s -f "${my_config_alacritty}" "$HOME/.config"
}
all_config(){
    echo "Sublime3 .config"
    sublime_config_folder
    nvim_config_folder
    tmux_config
}
current_dir="$(pwd)"
# DEBIAN SCRIPT
if [[ "$script_base" = "debian" ]]; then
    echo "debian-based distro identified"
    mkdir ~/.config
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
    echo "installing java"
    wget https://download.oracle.com/java/24/latest/jdk-24_linux-x64_bin.deb
    sudo dpkg -i jdk-24_linux-x64_bin.deb
    rm jdk-24_linux-x64_bin.deb
    echo "installing brave"
    curl -fsS https://dl.brave.com/install.sh | sh
    echo "installing tmux"
    sudo apt install tmux
    echo "installing zsh"
    sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "alacritty dependencies"
    sudo apt install cmake g++ pkg-config libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
    echo "installing alacritty"
    sudo cargo install alacritty
elif [[ "$script_base" = "arch" ]]; then
    echo "arch-based distro identified"
elif [[ "$script_base" = "invalid distro" ]]; then
    echo "invalid distro"
else
    echo "error"
fi
nvim_install
sublime_text_3_install
all_config
echo "INSTALLATION SCRIPT ENDED"
