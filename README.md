# My-TTGO-Watch-Bin-Flash

How to flash https://github.com/sharandac/My-TTGO-Watch/ttgo-t-watch2020_v1.ino.bin file without PlatformIO?


## 1. Required files

file|write to address|from
---|---|---
bootloader_dio_80m.bin|0x1000|https://github.com/espressif/arduino-esp32/blob/master/tools/sdk/bin/bootloader_dio_80m.bin
partitions.bin|0x8000|My-TTGO-Watch/.pio/build/ttgo-t-watch/partitions.bin or https://github.com/wlcims/My-TTGO-Watch-Bin-Flash/blob/master/data/partitions.bin
boot_app0.bin|0xe000|https://github.com/espressif/arduino-esp32/blob/master/tools/partitions/boot_app0.bin
ttgo-t-watch2020_v1.ino.bin|0x10000|https://github.com/sharandac/My-TTGO-Watch/blob/master/ttgo-t-watch2020_v1.ino.bin


## 2. Ubuntu

use `esptool.py`

### install `esptool.py`
```
pip install esptool
```

### upload script ([upload.sh](upload.sh))
```bash
#!/bin/bash

esptool.py --chip esp32 --port "/dev/ttyUSB0" --baud 2000000 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size detect 0x1000 bootloader_dio_80m.bin 0x8000 partitions.bin 0xe000 boot_app0.bin 0x10000 ttgo-t-watch2020_v1.ino.bin
```
> Put all files in the same folder   
> bootloader_dio_80m.bin  
> partitions.bin  
> boot_app0.bin  
> ttgo-t-watch2020_v1.ino.bin  
> upload.sh

## 3. Windows

use Flash Download Tools

### download
```
https://www.espressif.com/sites/default/files/tools/flash_download_tool_v3.8.5_1.zip
```

### upload 
![windows](https://raw.githubusercontent.com/wlcims/My-TTGO-Watch-Bin-Flash/master/images/Windows10.PNG)
> When the flashing is completed, you need to force the power off and restart by pressing the power button


## 4. Fast flash TTGO-T-Watch in PlatformIO environment


### upload script ([flash.sh](flash.sh))
```bash
#!/bin/bash

pio_path=`pio system info | grep "PlatformIO Core Directory" | sed 's/PlatformIO Core Directory\s*//'`
esptool.py --chip esp32 --port "/dev/ttyUSB0" --baud 2000000 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size detect 0x1000 ${pio_path}/packages/framework-arduinoespressif32/tools/sdk/bin/bootloader_dio_80m.bin 0x8000 .pio/build/ttgo-t-watch/partitions.bin 0xe000 ${pio_path}/packages/framework-arduinoespressif32/tools/partitions/boot_app0.bin 0x10000 .pio/build/ttgo-t-watch/firmware.bin
```