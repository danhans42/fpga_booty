# fpga_booty

An simple experiment/concept to see how well a PS1/PS-X can boot from an FPGA/CPLD with minimal connections.

![Alt text](/images/IMG_20210705_152344__022.jpg?raw=true "Schematic")

### Say What?

The PS-X/PS1 can boot from Expansion - whether there is a expansion socket or not. Usually this is done by an EEPROM & some PLD (like in the Xplorer/AR/GS).
EEPROMs need a fair amount of wiring (32 to be exact for 512k).

The idea is, rather than an EEPROM we use a CPLD/FPGA to give the PS-X the data it expects, without the need for address lines.

### Why?

Doing some development/homebrewing on a PSone currently requires either a boot disc or a memory card to load unirom or some serial client which isnt the fastest. The idea here is a small FPGA can be used to boot from on these consoles with just 12 wires (8 Data, /RD, CS0, GND & VCC) which requires a considerable amount of less wiring than an EEPROM.

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

### Does it work?

Yeah kinda, ish :) See youtube video below for an earlier version on a different board:-

[![Action Video](https://img.youtube.com/vi/7CAtqHSnnSg/0.jpg)](https://www.youtube.com/watch?v=7CAtqHSnnSg)

Currently trapping errors from a power on boot. Current attempt works correctly after 1 successive boot to the BIOS. After this you can restart to the code on the FPGA - work on this is ongoing

### Future Improvements

After the boot code has been read completely from the FPGA it essentially ignores future read requests (shows as open bus). Ideally some logic will be switched in that handles something like communication or otherwise. Lets see.

### Credit / Licence etc

Maany thanks to all in #psxdev discord for my mutterings and dumb questions - Nicolas Noble in particular who without this project wouldnt have happened. Bradlin for freepsxboot and also Sicklebrick for Unirom! Big shouts to all the usual suspects

The code contained in this repo is for personal, non-commercial use only. If you bought on eBay - you got shafted!

