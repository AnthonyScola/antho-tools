#!/bin/bash

#####################################################
#   Application Name: Enable Sound Redirection      #
#   Desc: This script enables sound redirection     #
#         from pulseaudio for xRDP sessions.        #
#                                                   #
#   By: Anthony Scola                               #
#   Last updated: 12/08/2023                        #
#####################################################

printf "\n\e[1;33m Enabling Sound Redirection....    \e[0m\n\n"

pulsever=$(pulseaudio --version | awk '{print $2}')

printf "\e[1;32m Install additional packages \e[0m\n"

# Check if the script is running with root privileges
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Check if apt is installed
if ! command -v apt &> /dev/null
then
  echo "apt could not be found"
  exit
fi

# Version Specific - adding source and correct pulseaudio version for Debian !!!
if [[ *"$version"* = *"Debian"*  ]]; then
  printf "\e[1;32m Install dev tools used to compile sound modules \e[0m\n\n"
  sudo apt install -qq libconfig-dev git libpulse-dev autoconf m4 intltool build-essential dpkg-dev libtool libsndfile-dev libcap-dev libjson-c-dev -y
  sudo apt build-dep -qq pulseaudio -y
  sudo apt update
fi

if  [[ *"$version"* = *"Mint"* ]]; then
  # Step 0 - Install Some PreReqs
  printf "\n\e[1;32m Enabling Sources Repository for Linux Mint \e[0m\n"

  # Add sources to the sources list
  sudo bash -c "cat >/etc/apt/sources.list.d/official-source-repositories.list" <<EOF
deb-src http://packages.linuxmint.com $codename main upstream import backport
deb-src http://archive.ubuntu.com/ubuntu $ucodename main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu $ucodename-updates main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu $ucodename-backports main restricted universe multiverse
deb-src http://security.ubuntu.com/ubuntu/ $ucodename-security main restricted universe multiverse
EOF

  sudo apt update
if

if [[ *"$version"* = *"Ubuntu"* ]]; then
  # Step 1 - Enable Source Code Repository
  printf "\e[1;32m Adding Source Code Repository \e[0m\n"

  sudo apt-add-repository -s -y 'deb http://archive.ubuntu.com/ubuntu/ '$codename' main restricted'
  sudo apt-add-repository -s -y 'deb http://archive.ubuntu.com/ubuntu/ '$codename' restricted universe main multiverse'
  sudo apt-add-repository -s -y 'deb http://archive.ubuntu.com/ubuntu/ '$codename'-updates restricted universe main multiverse'
  sudo apt-add-repository -s -y 'deb http://archive.ubuntu.com/ubuntu/ '$codename'-backports main restricted universe multiverse'
  sudo apt-add-repository -s -y 'deb http://archive.ubuntu.com/ubuntu/ '$codename'-security main restricted universe main multiverse'
  sudo apt update
fi

# Step 2 - Install Some PreReqs
sudo apt install git libpulse-dev autoconf m4 intltool build-essential dpkg-dev libtool libsndfile-dev libcap-dev libjson-c-dev libconfig-dev -y

# Additional Libs needed for other Distributions like Kubuntu (for security only)
sudo apt install meson libtdb-dev doxygen check -y

sudo apt build-dep pulseaudio -y

printf "\n\e[1;32m Download pulseaudio sources files \e[0m"
# Step 3 -  Download pulseaudio source in /tmp directory - Debian source repo should be already enabled
cd /tmp
apt source pulseaudio
printf "\e[1;32m Compile pulseaudio sources files \e[0m"

# Step 4 - Compile PulseAudio based on OS version & PulseAudio Version
cd /tmp/pulseaudio-$pulsever*
PulsePath=$(pwd)

cd "$PulsePath"
  if [ -x ./configure ]; then
    #if pulseaudio version <15.0, then autotools will be used (legacy)
    ./configure
  elif [ -f ./meson.build ]; then
      #if pulseaudio version >15.0, then meson tools will be used (new)
    sudo meson --prefix=$PulsePath build
  fi

# step 5 - Compile xrdp sound modules
printf "\e[1;32m Compiling xRDP Sound modules...\e[0m"
cd /tmp
git clone https://github.com/neutrinolabs/pulseaudio-module-xrdp.git
cd pulseaudio-module-xrdp
./bootstrap
./configure PULSE_DIR=$PulsePath
make
#this will install modules in /usr/lib/pulse* directory
sudo make install

#-- check if no error during compilation
if [ $? -eq 0 ]
then
  printf "\n\e[1;32m Compiled successfully!\nPlease Reboot to enable xRDP Sound.\e[0m\n"
else
  printf "\n\e[1;31m Sound Redirection failed! \e[0m"
  exit
fi
