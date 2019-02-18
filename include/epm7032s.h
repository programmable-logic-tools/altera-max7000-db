
#ifndef EPM7032S_H
#define EPM7032S_H


#include <stdint.h>

const uint8_t

typedef struct
{
    product_term_t lab[160];
    macrocell_t mc[32];
    pia_t pia[72];
    io_block_t io_block[];
} epm7032s_bitstream_t;


#endif
