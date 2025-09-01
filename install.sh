#!/bin/bash

echo "Nokx dot files configurer 0.0.1"
echo "verifying distro"
distro_id="$(cat /etc/*-release | grep "ID=")"
script_base="$(./distro_check $distro_id)"
# DEBIAN SCRIPT
if [[ "$script_base" = "debian" ]]; then
    echo "debian-based distro identified"
elif [[ "$script_base" = "arch" ]]; then
    echo "arch-based distro identified"
elif [[ "$script_base" = "invalid distro" ]]; then
    echo "invalid distro"
else
    echo "error"
fi

