#!/bin/bash

echo "Nokx dot files configurer 0.0.1"
echo "verifying distro"
distro_id="$(cat /etc/*-release | grep "ID=")"
echo "${distro_id}"
debian_based_distros=(
    "ubuntu"
    "linuxmint"
    "pop"
    "kali"
    "elementary"
)
