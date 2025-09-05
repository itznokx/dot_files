#!/bin/bash
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
    sublime_config_folder
    nvim_config_folder
    tmux_config
}
all_config
