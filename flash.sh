#!/bin/bash

pio_path=`pio system info | grep "PlatformIO Core Directory" | sed 's/PlatformIO Core Directory\s*//'`
esptool.py --chip esp32 --port "/dev/ttyUSB0" --baud 2000000 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size detect 0x1000 ${pio_path}/packages/framework-arduinoespressif32/tools/sdk/bin/bootloader_dio_80m.bin 0x8000 .pio/build/ttgo-t-watch/partitions.bin 0xe000 ${pio_path}/packages/framework-arduinoespressif32/tools/partitions/boot_app0.bin 0x10000 .pio/build/ttgo-t-watch/firmware.bin
