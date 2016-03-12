#!/bin/bash

le_path='/opt/letsencrypt'

echo '#############################'
echo '###                       ###'
echo '###  Letsencrypt manager  ###'
echo '###                       ###'
echo '#############################'
echo
echo 'What would you like to do:'
echo '  (1) Install letsencrypt'
echo '  (2) Register a domain'
echo '  (3) Renew a domain'
echo
echo -n 'Please choose a number: '
read choice

function title {
  echo -e "\e[32m$1"
}

function check_if_letsencrypt_installed {
  if [ ! -d $le_path ]; then
    echo -e "\n[ERROR] Please install letsencrypt first.\n"
    exit 0;
  fi
}

function install_letsencrypt {
  echo
  title 'Updating packages list...'
  echo `sudo apt-get update`
  title 'Installing git and bc...'
  echo `sudo apt-get -y install git bc`
  title 'Cloning letsencrypt...'
  echo `sudo git clone https://github.com/letsencrypt/letsencrypt $le_path`
}

function register_domain {
  check_if_letsencrypt_installed
  /opt/letsencrypt/letsencrypt-auto certonly --standalone
}

function renew_domain {
  check_if_letsencrypt_installed
  echo
  echo -n 'Enter your domain: '
  read -a app_domain
  echo -n 'Path to your application root folder: '
  read app_path
  $le_path/letsencrypt-auto certonly -a webroot --agree-tos --renew-by-default --webroot-path=$app_path -d ${app_domain[0]} -d ${app_domain[1]}
  title 'Done, reload your server'
}

if [ $choice -eq 1 ] ; then
  install_letsencrypt
elif [ $choice -eq 2 ] ; then
  register_domain
elif [ $choice -eq 3 ] ; then
  renew_domain
fi


