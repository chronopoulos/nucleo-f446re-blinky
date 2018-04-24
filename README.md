# nucleo-f446re-blinky
a minimal blinky example for the Nucleo-F446RE board, using the STM32F4
Standard Peripherals Library and the GNU ARM Toolchain

## Dependencies

```
apt-get install gcc-arm-none-eabi gdb-arm-none-eabi ia32-libs libnewlib-arm-none-eabi openocd
```

You'll also need to obtain the STM32F4 Standard Peripherals Library (SPL),
which is distributed by ST as STSW-STM32065.

## Instructions

First, modify `SPL_DIR` in the Makefile to point to the location of the SPL on
your system. Then,

```
make
make flash
```
