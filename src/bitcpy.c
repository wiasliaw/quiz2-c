#include "bitcpy.h"
#include <inttypes.h>
#include <stdio.h>
#include <string.h>

static uint8_t output[2], input[2];

static inline void dump_8bits(uint8_t _data)
{
    for (int i = 0; i < 8; ++i)
        printf("%d", (_data & (0x80 >> i)) ? 1 : 0);
    printf(" ");
}

static inline void dump_binary(uint8_t *_buffer, size_t _length)
{
    for (int i = 0; i < _length; ++i)
        dump_8bits(*_buffer++);
}

int main(int _argc, char **_argv)
{
    memset(&input[1], 0x55, sizeof(input) / 2);
    memset(&input[0], 0xAA, sizeof(input) / 2);
    dump_binary(&input[0], 2);
    printf("\n");
    memset(&output[0], 0x00, sizeof(output));
    bitcpy(&output[0], 2, &input[0], 4, 10);
    dump_binary(&output[0], 2);

    // for (int i = 1; i <= 32; ++i) {
    //     for (int j = 0; j < 16; ++j) {
    //         for (int k = 0; k < 16; ++k) {
    //             memset(&output[0], 0x00, sizeof(output));
    //             printf("%2d:%2d:%2d ", i, k, j);
    //             bitcpy(&output[0], k, &input[0], j, i);
    //             dump_binary(&output[0], 8);
    //             printf("\n");
    //         }
    //     }
    // }

    return 0;
}
