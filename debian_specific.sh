# this is not a bash script, rather best used as copy & paste since su command will start a new shell

#start root shell
su

apt-get update && apt-get upgrade
apt-get install curl
apt-get install git
apt-get install build-essential

# sudo is only needed to check if script is running as root. can be ommited
apt-get install sudo

# this next line makes sure the current user is allowed to use sudo (omit if not installing sudo)
echo "$USER ALL=(ALL:ALL) ALL" >> /etc/sudoers

#exit root shell
exit
