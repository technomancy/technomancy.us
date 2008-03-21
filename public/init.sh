#!/bin/bash

if [ `/usr/bin/whoami` != "root" ] ; then
    echo "You must be root."
    exit 1
fi

# enable universe
cp /etc/apt/sources.list /etc/apt/sources.list.orig
# Enable all disabled sources
sed -i -e "s/# deb/deb/g" /etc/apt/sources.list
# TODO: this doesn't enable multiverse. figure how to do this from the CLI
# We don't want backports though
sed -i -e "s/^.*backports.*$//g" /etc/apt/sources.list
apt-get update

# get the minimum
apt-get install git-core ruby zile

if [ -r install.rb ] ; then
    ruby install.rb
    su $USER ruby user-setup.rb
    exit 0
fi

# if we are running a bare go.sh
cd ~
git clone git://git.caboo.se/technomancy.git dotfiles
chown -R $USER dotfiles
cd dotfiles/bin/init
./go.sh
