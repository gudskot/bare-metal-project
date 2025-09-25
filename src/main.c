#include <stm32l053xx.h>

void _init(void) {};

int main(void) {
    RCC->IOPENR |= RCC_IOPENR_GPIOAEN;

    GPIOA->MODER &= ~(3 << (2 * 0));
    GPIOA->MODER |= (1 << (2 * 0));

    GPIOA->MODER &= ~(3 << (2 * 1));
    GPIOA->MODER |= (1 << (2 * 1));

    while(1) {
        GPIOA->ODR ^= (1 << 0);
        for(int i = 0; i < 100000; i++) {};
        GPIOA->ODR ^= (1 << 1);
    };
}