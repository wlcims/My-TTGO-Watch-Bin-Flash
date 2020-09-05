#!/bin/bash
esptool.py --chip esp32 --port "/dev/ttyUSB0" --baud 2000000 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size detect 0x1000 bootloader_dio_80m.bin 0x8000 partitions.bin 0xe000 boot_app0.bin 0x10000 firmware.bin
