#!/bin/sh
# Simple script to run the playbook
if [ ! -x /usr/bin/ansible ]; then
  echo "Missing Ansible, Running Install"
  if [ -x /usr/bin/apt ]; then
    # I'm not doing anything fancy, so older version from repo is okay
    apt install -f ansible
  fi
fi
ansible-playbook install-desktop-toolsontech.yml
