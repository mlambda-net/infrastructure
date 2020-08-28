#!/bin/bash

# Install Ansible and use `ansible-pull` to run the playbook for this instance.

# Some sane options.
set -e # Exit on first error.
set -x # Print expanded commands to stdout.

function setup() {
  declare -r url=$1 path=$2 playbook=$3
  sudo apt update
  sudo apt -y install python3-pip
  sudo pip3 install ansible
  sudo apt -y autoremove
  cd /home/ubuntu
  git clone "$url"
  cd "$path"
  sudo ansible-playbook "$playbook"
}

setup "https://github.com/mlambda-net/infrastructure.git" "infrastructure/playbook" "vpn.yml"
