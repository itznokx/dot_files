#!/bin/bash

echo "Dependencies Installer 0.0.1"

echo "verifying distro"
distro_id="$(cat /etc/*-release | grep "ID=")"
echo "${distro}"

