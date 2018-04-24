#include "stm32f4xx.h"
#include "stm32f4xx_gpio.h"
#include "stm32f4xx_syscfg.h"
#include "stm32f4xx_rcc.h"
#include "stm32f4xx_exti.h"
#include "misc.h"

static void delay_clockCycles(__IO uint32_t ncycles) {

    while(ncycles--) {
        __asm("nop");
    }

}

GPIO_InitTypeDef GPIO_InitStructure;

void setup_leds(void) {

    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOA, ENABLE);

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_5;

    GPIO_InitStructure.GPIO_Mode  = GPIO_Mode_OUT;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_100MHz;
    GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
    GPIO_InitStructure.GPIO_PuPd  = GPIO_PuPd_NOPULL;

    GPIO_Init(GPIOA, &GPIO_InitStructure);

}

void led_on(void) {

    GPIO_SetBits(GPIOA, GPIO_Pin_5);

}

void led_off(void) {

    GPIO_ResetBits(GPIOA, GPIO_Pin_5);

}

int main(void) {

    setup_leds();

    while (1) {
        led_on();
        delay_clockCycles(8000000L);
        led_off();
        delay_clockCycles(8000000L);
    }

    return 0;

}
