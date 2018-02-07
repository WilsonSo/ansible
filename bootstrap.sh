#!/bin/sh

###
#
# self installation for ansible
#
# pull from git and run ansible-playbook
#
# run this file as root
#
###


# root check
if [ $(id -u) -ne 0 ];
then
  echo "This script must be run as root"
  exit 1
fi


# pip check
if [ -z $(which pip) ];
then
  apt-get install python-pip -y
fi


# ansible check
if [ -z $(which ansible) ];
then
  pip install ansible
fi


# git check
if [ -z $(which git) ];
then
  apt-get install git
fi


# repo check
if [ -d /home/socen/development/ansible ];
then
  cd /home/socen/development/ansible
  git pull
else
  mkdir -p /home/socen/development
  git clone https://github.com/WilsonSo/ansible.git
  cd ansible
fi


# case statement for arguments
arg=$1

case $arg
in
  check)
    echo "Running ansible check"
    ansible-playbook playbooks/ubuntu-desktop.yaml -K --check
    ;;
  diff)
    echo "Running ansible check and diff"
    ansible-playbook playbooks/ubuntu-desktop.yaml -K --check --diff
    ;;
  *)
    echo "Running ansible"
    ansible-playbook playbooks/ubuntu-desktop.yaml -K
    ;;
esac