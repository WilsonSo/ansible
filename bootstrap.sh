#!/bin/sh

###
#
# self installation for ansible
#
# pull from git and run ansible-playbook
#
###

set -x

if [ -z $(which pip) ];
then
  apt-get install python-pip -y
fi

if [ -z $(which ansible) ];
then
  pip install ansible
fi

if [ -z $(which git) ];
then
  apt-get install git
fi

if [ -d /home/$(whoami)/development/ansible ];
then
  cd /home/$(whoami)/development/ansible
  git pull
else
  mkdir -p /home/$(whoami)/development
  git clone https://github.com/WilsonSo/ansible.git
  cd ansible
fi

if [ -n $(which ansible) ];
then
  ansible-playbook playbooks/ubuntu-desktop.yaml -K
fi
