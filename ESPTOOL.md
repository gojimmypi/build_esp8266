 This command used to work:

 ~/workspace/esptool/esptool.py --port /dev/ttyUSB0 --baud 115200 write_flash --flash_size=8m 0 ~/workspace/micropython/esp8266/build/firmware-combined.bin

esptool.py v2.0-beta2
Connecting....
Detecting chip type... ESP8266
Uploading stub...
Running stub...
Stub running...
Attaching SPI flash...
Configuring flash size...
Flash params set to 0x0020
Compressed 573408 bytes to 375743...
Wrote 573408 bytes (375743 compressed) at 0x00000000 in 33.9 seconds (effective 135.4 kbit/s)...
Hash of data verified.

Leaving...
Hard resetting...

but gives errors, spewing this error over and over:

 ets Jan  8 2013,rst cause:2, boot mode:(3,7)

load 0x40100000, len 32096, room 16
tail 0
chksum 0x8d
load 0x3ffe8000, len 1088, room 8
tail 8
chksum 0xfa
load 0x3ffe8440, len 3000, room 0
tail 8
chksum 0x9f
csum 0x9f
#0 ets_task(40209c08, 31, 3ffe9010, 4)
rf_cal[0] !=0x05,is 0xFF

The reason for this is the esptool.py has changed and no longer requires the --flash_size parameter (and if specified, no lponger wants units in bits!)
