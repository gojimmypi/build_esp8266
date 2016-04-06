#!/bin/bash
#*********************************************************************************************
# ESP8266 MicroPython Firmware Build on RPi, by gojimmypi
#
#  version 0.01 (coming to github soon)
#
#  GNU GENERAL PUBLIC LICENSE
#
# NOTE: you will need a lot of free disk space. This will likely not work on an 8GB RPi SD.
#
# For new RPi install, on a windows machine:
#
# download latest raspian
# https://downloads.raspberrypi.org/raspbian_latest
#
# for info see https://www.raspberrypi.org/downloads/raspbian/
#
# download win32diskimager
# https://sourceforge.net/projects/win32diskimager/files/Archive/Win32DiskImager-0.9.5-install.exe/download
#
# for info see https://sourceforge.net/projects/win32diskimager/
#


#*******************************************************************************************************
#
#*******************************************************************************************************
# update RPi firmware
sudo rpi-update

# standard update
sudo apt-get update && time sudo apt-get dist-upgrade

# git should be installed, but let's just be sure

sudo apt-get install git

# completely optional, but I like to have xrdp (so that I can use Windows remote desktop)
# sudo apt-get install xrdp

# also optional is samba, so that I can mount the RPi as a Windows share
# can be very handy for getting files onto & off of RPi
# sudo apt-get install samba samba-common-bin
# sudo smbpasswd -a pi
# sudo smbpasswd -a root

## edit the file /etc/samba/smb.conf and put in these lines at the end (without single # comment markers!)
##*******************************************************************************************************
# [home]
#   comment= root
#   path=/home/pi
#   browseable=Yes
#   writeable=Yes
#   only guest=no
#   create mask=0777
#   directory mask=0777
#   public=no
#


# every linux user should know how to use VI / VIM, right?
# sudo apt-get install vim

# I also like to have the optional dns tools installed (optional)
# sudo apt-get install dnsutils

# this is the big ESP8266 requirement install from pfalcon (slightly modified)
sudo apt-get install make autoconf automake libtool gcc g++ gperf flex bison texinfo gawk ncurses-dev libexpat-dev python python-serial sed git unzip bash

# listed as "maybe" but was required for me on raspian jessie
sudo apt-get install libtool-bin

# unrar install gave an error this error, so pulled out into separate install
# even with the error, sees to work ok
#
# Package unrar is not available, but is referred to by another package.
# This may mean that the package is missing, has been obsoleted, or
# is only available from another source
sudo apt-get install unrar


# now for the source code

# we'll put everything in the home workspace directory
cd ~
if ! [[ -a ~/workspace ]]; then
  echo create directory: workspace
  mkdir ~/workspace
fi



#*******************************************************************************************************
# next git the pfalcon esp-open-sdk
# (I believe pfalcon warning that the esp=open-sdk need to be rebuilt fresh every time!)
#*******************************************************************************************************
cd ~/workspace
if ! [[ -a ~/workspace/esp-open-sdk ]]; then
  echo git esp-open-sdk
  git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
fi

cd ~/workspace/esp-open-sdk
git submodule update --init

# compile esp-open-sdk (this takes a ridiculously long time)
make

# should evenually get a message like this at the end. (note important path note!)
#
# Xtensa toolchain is built, to use it:
#
# export PATH=/home/pi/workspace/esp-open-sdk/xtensa-lx106-elf/bin:$PATH
#
# Espressif ESP8266 SDK is installed, its libraries and headers are merged with the toolchain
#

# be sure to add the path as suggested (TODO - is it already in the path?)
export PATH=/home/pi/workspace/esp-open-sdk/xtensa-lx106-elf/bin:$PATH

#*******************************************************************************************************
# next git micropython source
#*******************************************************************************************************
cd ~/workspace

if ! [[ -a ~/workspace/micropython ]]; then
  echo git micropython
  git clone --recursive https://github.com/micropython/micropython.git
fi

cd ~/workspace/micropython/
git submodule update --init

make

cd ~/workspace/micropython/esp8266

#*******************************************************************************************************
# show the newly built firmware
#*******************************************************************************************************
ls ~/workspace/micropython/esp8266/build/firmware* -al


#*******************************************************************************************************
# git the esptool
#*******************************************************************************************************
cd ~/workspace
if ! [[ -a ~/workspace/esptool ]]; then
  echo git esptool
  git clone https://github.com/themadinventor/esptool/
fi

chmod +x ~/workspace/esptool/esptool.py

#*******************************************************************************************************
# # uncomment if you want to erase the flash (a good idea before applying new firmware)
#*******************************************************************************************************
# ~/workspace/esptool/esptool.py --port /dev/ttyUSB0 erase_flash


#*******************************************************************************************************
# uncomment send newly compiled image to your ESP8266
#*******************************************************************************************************
#~/workspace/esptool/esptool.py --port /dev/ttyUSB0 --baud 460800 write_flash --flash_size=8m 0 \
                                      ~/workspace/micropython/esp8266/build/firmware-combined.bin
#
# successful write should look like this:
#
#Connecting...
#Erasing flash...
#Took 1.55s to erase flash block
#Wrote 409600 bytes at 0x00000000 in 13.7 seconds (238.7 kbit/s)...
#
#Leaving...
#

#****************************************************************************************
# Note the default serial parameters for ESP8266 are:
# 115200 buad, 8 data bits, 1 stop bit, No Parity, No flow control

# uncomment to configure minicom, without connecting
# minicom -o -s

# ready to connect!
# reminder Ctril-A Z X to exit minocom
# minicom --device /dev/ttyUSB0 115200

# you probably want to reset the ESP8266 after fresh firmware
# connect first, and see the very first startup message!


#****************************************************************************************
# other fun stuf....
#****************************************************************************************

# Perhaps we'll consider playing with I2C on the RPi, such as the RTC1307
#
# uncomment to run raspi-config (needed to enable kernel support for I2C)
# sudo raspi-config

# uncomment to add pi as I2C user
# sudo adduser pi i2c

# uncomment to install the I2C tools
# sudo apt-get install i2c-tools

# uncommment to turn on support for the RTC 1307 Real time Clock
# echo ds1307 0x68 | sudo tee /sys/class/i2c-adapter/i2c-1/new_device

# uncomment to remove RTC1307
# echo 0x68 | sudo tee /sys/class/i2c-adapter/i2c-1/delete_device

# Note that the RTC1307 typically needs an LIR2302 (rechargable!) battery.
# Be careful with non-rechargables. If used, consider removing charing resistors.
#
# if your RPi has the correct time, uncomment to set RTC clock to RPi time
# sudo hwclock -w

# uncomment to read the time from the RTC clock
# sudo hwclock -r

# uncomment if you want to play with I2C stuff on the RPi python,
# sudo apt-get install python-dev
# sudo apt-get install python-smbus
#   or python 3:
# sudo apt-get install python3-smbus
# sudo apt-get install python3-dev


# uncomment if you have a file called myI2C.py, and want to send it to the ESP8266 via pyboard.py
# python pyboard.py --device /dev/ttyUSB0 myI2C.py

# uncomment if you want to quickly see if the ESP8266 is operational
# python pyboard.py --device /dev/ttyUSB0 -c 'print("hello world")'

# uncomment if you con't want to use minicom but need to open a terminal session to ESP8266
# sudo screen /dev/ttyUSB0 115200
# reminder:
# Ctrl-A Ctrl-D to detach, then connect later with screen -r   (holds the serial port in use!)
# per deshipu: To exit screen, use "ctrl+a ctrl+k" or "ctrl+a ctrl+K" (the latter if you don't want a confirmation question).

