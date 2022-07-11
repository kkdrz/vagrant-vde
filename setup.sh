#!/bin/env bash

# update the system
export DEBIAN_FRONTEND=noninteractive
apt-mark hold keyboard-configuration
apt-get update
apt-get -y upgrade
apt-mark unhold keyboard-configuration

################################################################################
# Install the mandatory tools
################################################################################

# install utilities
apt-get -y install vim git zip bzip2 fontconfig curl language-pack-en

# install Java 11
apt-get -y install openjdk-11-jdk

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# install Node.js
nvm install --lts

# update NPM
npm install -g npm

# install Yarn
npm install -g yarn
su -c "yarn config set prefix /home/vagrant/.yarn-global" vagrant

################################################################################
# Install GUI (Cinnamon)
################################################################################

# force encoding
echo 'LANG=en_US.UTF-8' >> /etc/environment
echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
echo 'LC_CTYPE=en_US.UTF-8' >> /etc/environment

# run GUI as non-privileged user
echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config

# install GUI and VirtualBox guest tools
apt-get install -y cinnamon-desktop-environment virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

################################################################################
# Install ZSH
################################################################################

# install zsh
apt-get install -y zsh

# install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh) vagrant
echo 'SHELL=/bin/zsh' >> /etc/environment

# change user to vagrant
chown -R vagrant:vagrant /home/vagrant/.zshrc /home/vagrant/.oh-my-zsh

################################################################################
# Install the development tools
################################################################################

# install pip
apt-get install -y python-pip

# install Chromium Browser
apt-get install -y chromium-browser

# install IntelliJ
wget https://download.jetbrains.com/idea/ideaIU-2022.1.3.tar.gz -O /home/vagrant/Downloads/ideaIU.tar.gz
sudo tar -xzf /home/vagrant/Downloads/ideaIU.tar.gz -C /opt

# increase Inotify limit (see https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit)
echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/60-inotify.conf
sysctl -p --system

# install latest Docker
curl -sL https://get.docker.io/ | sh

# install latest docker-compose
curl -L "$(curl -s https://api.github.com/repos/docker/compose/releases | grep browser_download_url | grep Linux | grep -v sha256 | head -n 1 | cut -d '"' -f 4)" > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# configure docker group (docker commands can be launched without sudo)
usermod -aG docker vagrant

# fix ownership of home
chown -R vagrant:vagrant /home/vagrant/

# clean the box
apt-get -y autoclean
apt-get -y clean
apt-get -y autoremove
dd if=/dev/zero of=/EMPTY bs=1M > /dev/null 2>&1
rm -f /EMPTY