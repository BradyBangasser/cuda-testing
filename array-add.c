#include <stdio.h>
#include <stdint.h>

int main() {
    volatile uint32_t sum = 0;
    volatile uint32_t array[5];
    int i;

    for (i = 0; i < sizeof(array) / sizeof(uint32_t); i++) {
        array[i] = i + 16;
    }

    for (i = 0; i < sizeof(array) / sizeof(uint32_t) ; i++) {
        sum += array[i];
    }

    printf("%d\n", sum);
    
    return 0;
}
