PROJ_NAME = blinky

CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

# MODIFY THIS: path to STM32 Standard Peripheral Library
SPL_DIR = ../../software/STM32F4xx_DSP_StdPeriph_Lib_V1.8.0

SPL_SRCS += $(SPL_DIR)/Libraries/CMSIS/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c
SPL_SRCS += $(SPL_DIR)/Libraries/CMSIS/Device/ST/STM32F4xx/Source/Templates/TrueSTUDIO/startup_stm32f446xx.s
SPL_SRCS += $(SPL_DIR)/Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_gpio.c
SPL_SRCS += $(SPL_DIR)/Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_rcc.c 

INC_DIRS += -I$(SPL_DIR)/Libraries/CMSIS/Include # arm_math.h core_cm4.h
INC_DIRS += -I$(SPL_DIR)/Libraries/CMSIS/Device/ST/STM32F4xx/Include # stm32f4xx.h  system_stm32f4xx.h
INC_DIRS += -I$(SPL_DIR)/Libraries/STM32F4xx_StdPeriph_Driver/inc # stm32f4xx_gpio.h, stm32f4xx_rcc.h
INC_DIRS += -I$(SPL_DIR)/Project/STM32F4xx_StdPeriph_Examples/GPIO/GPIO_IOToggle # stm32f4xx_conf.h

DEFS += -DUSE_STDPERIPH_DRIVER
DEFS += -DSTM32F446xx

CFLAGS += -Wall -Wextra -Warray-bounds
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -mthumb-interwork
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16

LFLAGS += -T$(SPL_DIR)/Project/STM32F4xx_StdPeriph_Templates/TrueSTUDIO/STM32F446xx/STM32F446ZE_FLASH.ld
LFLAGS += --specs=nosys.specs

$(PROJ_NAME).elf: main.c
	$(CC) $(INC_DIRS) $(DEFS) $(CFLAGS) $(LFLAGS) $(SPL_SRCS) $^ -o $@ 
	$(OBJCOPY) -O ihex $(PROJ_NAME).elf   $(PROJ_NAME).hex
	$(OBJCOPY) -O binary $(PROJ_NAME).elf $(PROJ_NAME).bin

.PHONY: clean flash

clean:
	rm -f *.o $(PROJ_NAME).elf $(PROJ_NAME).hex $(PROJ_NAME).bin

flash:
	openocd -f interface/stlink-v2-1.cfg -f target/stm32f4x.cfg -c "program blinky.elf verify reset exit"

