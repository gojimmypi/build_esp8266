#!/bin/bash
# a common location for the SDK is /opt/esp-open-sdk
# so link our local workspace to /opt/esp-open-sdk
sudo ln -s /home/pi/workspace/esp-open-sdk /opt/esp-open-sdk

# Note for Makefile settings:
echo "Reaminder to Edit Makefile:"
echo ""
echo "Change the XTENSA_TOOLS_ROOT variable to /opt/esp-open-sdk/xtensa-lx106-elf/bin"
echo "Change the SDK_BASE variable to /opt/esp-open-sdk/sdk"


if [[ $PATH != */opt/esp-open-sdk/xtensa-lx106-elf/bin* ]]; then
  export PATH=/opt/esp-open-sdk/xtensa-lx106-elf/bin:$PATH
fi


if [[ $PATH != */opt/esp-open-sdk/esptool* ]]; then
  export PATH=/opt/esp-open-sdk/esptool:$PATH
fi

echo "Cuurent path="
echo ""
echo "$PATH"


