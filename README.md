# fpga_booty - PlayStation Expansion Boot with FPGA

An simple experiment/concept to see how well a Sony PlayStation can boot from an FPGA/CPLD with minimal connections.

There will be no further updates to this project. It was a test to check how something worked. Feel free to use it/change/modify it.

If you find it useful let me know :)

![Alt text](/images/IMG_20210705_152344__022.jpg?raw=true "Schematic")

### Say What?

The PS-X/PS1 can boot from its expansion port - whether there is a expansion socket or not. Usually this is done by an EEPROM & some PLD (like in the Xplorer/AR/GS).
EEPROMs need a fair amount of wiring (32 to be exact for 512k).

The idea is, rather than an EEPROM we use a CPLD/FPGA to give the PS-X the data it expects, without the need for address lines.

### Why?

Doing some development/homebrewing on a PSone currently requires either a boot disc or a memory card to load unirom or some serial client which isnt the fastest. The idea here is a small FPGA can be used to boot from on these consoles with just 13 wires (8 Data, /RD, /CS0, /RESET, GND & VCC) - which requires a considerable amount of less wiring than an EEPROM and not much more than an old skool modchip really.

The original idea/concept was by Nicolas Noble. I kind of understood it and used it as the basis for a simple FPGA project. He has been kind enough to help with the Playstation software whilst I kind of fool around in Quartus trying to bring this to life.

### How?

We have some logic wired up, so whenever the PSX reads from expansion (CS0 & RD go low) we increment a counter, the counter feeds the address lines of a 'virtual' ROM within the FPGA, and presents it to the bus just like an normal EEPROM.

Currently we are using the stage2 bootloader from FreePSXboot. So the PSX loads the stage2 bootloader from the FPGA and then proceeds to load UNIROM from the memory card.

### Why Intel/Altera/Quartus?

I am a complete n00b with CPLD/FPGAs and Verilog. About 18 months ago I picked up a cheapy EPM240 MAX II CPLD board and started playing around with the schematic editor hence me sticking with it. EPM240 isnt much use for this, so have upgraded it to a Cyclone II EP2C5.

The EP2C5 Mini Board can be obtained cheaply from eBay/Aliexpress/Amazon for around £18-20 (Aliexpress is around £11).

Once we have everything working 100%, hopefully can look at moving this to other cheaper FPGA/CPLD boards

### What do I need to get started?

- Some FPGA board - if you want to use the stuff I have written stick with a EP2C5 Mini Board

- A PlayStation - This was built with the PSone user in mind - however you can use this on a Full Fat PSX too. A 5552 PAL unit was used for development, however it should run on any model.

Something to connect it up - Jumper wires or whatever. Buy quality and keep them nice and short or you will have issues probably.
I used the PIO-Breakout from the pcsx-redux project (see https://github.com/grumpycoders/pcsx-redux/tree/main/hardware/PIO-Breakout )
### Does it work?

Yeah kinda, ish :) See youtube video below for an earlier version on a different board:-

[![Action Video](https://img.youtube.com/vi/7CAtqHSnnSg/0.jpg)](https://www.youtube.com/watch?v=7CAtqHSnnSg)

Currently trapping errors from a power on boot. Current attempt works correctly after 1 successive boot to the BIOS. After this you can restart to the code on the FPGA.

The project in this repo requires Quartus 13.0sp1 - do not use a newer version as it might not support the FPGA used.

Update:  Mar 2023. Support for creation of a booty bytestream is now supported by the ps1-packer tool by Nicolas Noble. It is part of the pcsx-redux repository and can be found here: https://github.com/grumpycoders/pcsx-redux/tree/main/tools/ps1-packer By providing a ps exe as an put, along with the -booty switch ps1-packer will compress and output a .BIN file that can be used to boot that code using this method. 

example 

<pre>C:\Users\danhans42\psxpong\>ps1-packer psxpong.ps-exe -booty -o booty_out.bin

ps1-packer by Nicolas "Pixel" Noble
https://github.com/grumpycoders/pcsx-redux/tree/main/tools/ps1-packer/

Input file: psxpong.ps-exe
pc: 0x80010000  gp: 0x00000000  sp: 0x801fff00
bss: 0@0x00000000
code size: 18432 -> 6420
loading address: 0x80013083
inplace decompression: yes
booty bytestream: yes

new pc: 0x80014964
File booty_out.bin created. All done.
</pre>

You will need to convert the resulting BIN file to an SREC, and then amend the storage element in the FPGA design to use it.

Maximum file size will depend on the fpga you are using. EP2C4 for example is limited to about 8KB.

### Future Improvements

After the boot code has been read completely from the FPGA it essentially ignores future read requests (shows as open bus). Ideally some logic will be switched in that handles something like communication or otherwise. Lets see.

### Credit / Licence etc

Maany thanks to all in psx.dev discord (http://psx.dev/) for my mutterings and dumb questions - Nicolas Noble in particular who without this project wouldnt have happened - his idea and concept I just merely interpreted it. Bradlin for freepsxboot (we use fastboot here) and also Sicklebrick for Unirom! 

The code contained in this repo is for personal, non-commercial use only. If you bought on eBay - you got shafted!

