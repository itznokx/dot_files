#!/bin/bash

echo "Nokx dot files configurer 0.0.1"
echo "verifying distro"
distro_id="$(cat /etc/*-release | grep "ID=")"
script_base="$(./distro_check $distro_id)"
echo "${script_base} kksadjasldk"