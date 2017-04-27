#!/bin/bash
# a common location for the SDK is /opt/esp-open-sdk
# so link our local workspace to /opt/esp-open-sdk
sudo ln -s /home/pi/workspace/esp-open-sdk /opt/esp-open-sdk

# Note for Makefile settings:
echo "Reminder to Edit Makefile:"
echo ""
echo "Change the XTENSA_TOOLS_ROOT variable to /opt/esp-open-sdk/xtensa-lx106-elf/bin"
echo "Change the SDK_BASE variable to /opt/esp-open-sdk/sdk"


if [[ $PATH != */opt/esp-open-sdk/xtensa-lx106-elf/bin* ]]; then
  export PATH=/opt/esp-open-sdk/xtensa-lx106-elf/bin:$PATH
fi


if [[ $PATH != */opt/esp-open-sdk/esptool* ]]; then
  export PATH=/opt/esp-open-sdk/esptool:$PATH
fi

echo "Current path="
echo ""
echo "$PATH"


# these next values were added for compiling the CP/M Z80 emulator from https://github.com/SmallRoomLabs/cpm8266
export ESP8266SDK=/opt/esp-open-sdk/
export ESPPORT=/dev/ttyUSB0
export ESPTOOL=/opt/esp-open-sdk/esptool/esptool.py

echo "Current ESP8266SDK=$ESP8266SDK"
echo "Current ESPPORT=$ESPPORT"
echo "Current ESPTOOL=$ESPTOOL"
Makefile:180: recipe for target 'flashinit' failed
make: *** [flashinit] Error 2