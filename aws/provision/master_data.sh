#!/bin/bash

# Install Ansible and use `ansible-pull` to run the playbook for this instance.

# Some sane options.
set -e # Exit on first error.
set -x # Print expanded commands to stdout.

function setup() {
  declare -r url=$1 playbook=$2
  sudo yum update
  sudo yum -y install apache2
  sudo yum -y install python3-pip
  sudo pip3 install ansible
  sudo yum -y autoremove
}

setup "" ""
