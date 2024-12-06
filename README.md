# victor-body-firmware

This repo contains/will contain bodyboard DFUs, .BINs, and edited DFUs.

## whiskey

These bodyboard DFUs are the only ones that work on Whiskey prototypes. Their SWD inteface is open, so you could mess around in there.

## prod

These bodyboard firmwares work on PVT and prod bots. These bots have their SWD interface completely disabled unless you replace the STM32 chip.

## dvt3-4

DVT3 bots are different compared to DVT4, however they run the same bodyboard firmware.

With an ST-LINK V2, you can flash a new body-bootloader onto a DVT3 bodyboard which allows them to run prod body firmware, and they work perfectly with it. The file to flash is called `dvt3-skipverify-1.6syscon.bin`. More ST-LINK info will be near the end of this readme.

ST-LINK note: It is recommended you get an official ST-LINK, as DVT3 requires NRST to be used. It is possible to reset the board manually, but it is finnicky. 

DVT4 bots are identical to production bots, but their body-bootloader only allows them to run DVT3 DFUs and their SWD inteface is closed so they can't be upgraded without soldering on a new blank STM32.

## dvt2

These are bodyboard files meant to be run on DVT2. 

These bodies can be upgraded via SWD to run production firmware, however it requires some edits. This folder contains a .bin containing a bootloader without signing and 1.6 DFU with the necesarry edit. This can be flashed directly to the board via SWD. The only problem with DVT 2 bodyboards is that they don't charge the battery on modern firmware.

ST-LINK note: Unlike DVT3 bodyboards, DVT2 bodies allow for reset-over-SWD. This means you don't have to solder on the NRST pin.

## dvt1

Same as DVT2, pretty much except that DVT 1 can have a 1.4 DFU flashed which is much more stable compared to 1.6 in testing.

## pre-dvt1

These DFUs are pre-DVT, and can be dangerous. If flashed on newer boards, damage can occur which I am not responsible for.

## ST-LINK info

**DVT4-prod:** no

**DVT3:** Solder wires to these pins on the bodyboard, and hook them up to the ST-LINK you have. Rightmost (in the picture) is GND, next to that is NRST, then SWDIO, then SWCLK. Put the bot on the charger and make sure it is on. In the official ST-LINK utility on Windows (openOCD and others probably work too) press connect and do what you want. To program, go into the `Target` tab, press `Program`, select the `dvt3-skipverify-1.6syscon.bin`, then flash.

If you have an ST-LINK clone (size of a flash drive, metal enclosure), the RST pin probably isn't used in STM32 mode. This can be worked around. Make sure the bot is on the charger, all the other pins are hooked up, and you have a good way to short NRST and GND. Some people may put a pushbutton there, some may just slide a DuPont on the unused GND on the ST-LINK. Press connect in the utility, immediately short NRST and GND, keep it shorted for 2 seconds, then let go and you should be connected.

**DVT1-2:** You can do the same steps as DVT3, however you don't need to worry about NRST. All you need to hook up is GND, SWCLK, and SWDIO. When those are hooked up, make sure the board is off, put the board on the charger, and immediately (sometime within 2 seconds after the board first shows a circle light) press connect in the utility. On DVT 1, program `DVT1-2-1.4-SYSCON-FAKE2.0-SYSCON.bin`. On DVT 2 program `dvt1-2-1.6dfu-edited-working.bin`

*Pre-DVT1:* Probably the same as DVT1-2. I don't expect that it works with production firmware.

*Whiskey:* Same as DVT3 but don't program `dvt3-skipverify-1.6syscon.bin`

## Extra info
All these bodyboard DFU files should work fine on a DVT body with a PROD head but some files will require a DEV head such as `dvt3-skip_verify-1.4.bin` and `dvt3-1.4_syscon.bin`.

# Credits

Very very big thanks to [@randym32](https://github.com/randym32). for figuring out the firmware, removing the signing, and figuring out how to get DVT1(/2) boards working on the latest DFU!!

Thanks to [Raj-jyot Deol/Switch-modder](https://github.com/Switch-modder) and his bot Viccy for accidently flashing her bodyboard giving us access to the 1.4 DVT 1 bodyboard DFU.
