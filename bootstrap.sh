#!/usr/bin/env sh

# self installation for ansible
#
# pull from git and run ansible-playbook
#
# run this file as root
#
###


# root check
if [ "$(id -u)" -ne 0 ];
then
  echo "This script must be run as root"
  exit 1
fi

if [ "$(uname -s)" == "Linux" ]; then
  if [ -z "$(which pip)" ]; then
    apt-get install python-pip -y
  fi
elif [ "$(uname -s)" == "Darwin" ]; then
  if [ -z "$(which pip)" ]; then
    easy_install pip
  fi

  if [ -z "$(which brew)" ]; then
    su socen -c 'yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  fi
else
  echo "This is neither a Macbook or a Linux Machine"
  return
fi

# ansible check
if [ -z "$(which ansible)" ];
then
  pip install ansible
fi

# case statement for arguments
arg=$1
playbookPath="ansible-playbook playbooks/desktop-setup.yaml -K"

case $arg
in
  check)
    echo "Running ansible check"
    ${playbookPath} --check
    ;;
  diff)
    echo "Running ansible check and diff"
    ${playbookPath} --check --diff
    ;;
  *)
    echo "Running ansible"
    ${playbookPath}
    ;;
esac
