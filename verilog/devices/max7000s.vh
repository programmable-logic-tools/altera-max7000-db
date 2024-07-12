
`ifndef MAX7000S_VH
`define MAX7000S_VH

// `include "max7000_family.vh"

// LABs always have exactly 16 macrocells
`define MACROCELLS_PER_LAB              16
`define NUM_MACROCELLS                  (`LAB_COUNT * `MACROCELLS_PER_LAB)

// Dedicated input signals: GCLK1, GCLRn, OE1 and OE2
`define NUM_DEDICATED_INPUTS            4

// All dedicated inputs, I/O pins and macrocell outputs feed the PIA
`define NUM_PIA_SIGNALS                 (`NUM_DEDICATED_INPUTS + `IO_COUNT + `NUM_MACROCELLS)

//  The number of signals routed into a LAB from the PIA is fixed
`define NUM_LAB_SIGNALS_FROM_PIA        36
`define NUM_REGIONAL_FOLDBACK_SIGNALS   16

/*
 * All product terms are configured in sequence within the bitstream
 */
`define BITS_PER_PRODUCT_TERM           (`NUM_LAB_SIGNALS_FROM_PIA * 2 + `NUM_REGIONAL_FOLDBACK_SIGNALS)
`define NUM_BITS_PRODUCT_TERM_CONFIG    (`NUM_MACROCELLS * `PRODUCT_TERMS_PER_MACROCELL * `BITS_PER_PRODUCT_TERM)


/*
 * The selection of the PIA signals routed to all LABs is configured in sequence within the bitstream
 */

`define NUM_PIA_TO_LAB_ROUTERS          `LAB_COUNT
`define NUM_BITS_PIA_TO_LAB_ROUTING     (`NUM_PIA_TO_LAB_ROUTERS * `BITS_PER_PIA_TO_LAB_ROUTER)


`define BITS_PER_IOB                    6


// TODO: Calculate total number of bits
// `define TOTAL_BIT_COUNT                 15033
`define TOTAL_BIT_COUNT                 (`NUM_BITS_PRODUCT_TERM_CONFIG + `NUM_BITS_MACROCELL_CONFIG + `NUM_BITS_PIA_TO_LAB_ROUTING + `NUM_BITS_TRISTATE_CONFIG)


/*
 * In the MAX7000S series a macrocell can select the clear signal
 * from one more global clear signal
 */
`define BITS_PER_MACROCELL              13
`define NUM_BITS_MACROCELL_CONFIG       (`NUM_MACROCELLS * `BITS_PER_MACROCELL)

/*
 * The selection of the PIA signals routed to all LABs is configured in one block
 */
`define BITS_PER_PIA_TO_LAB_ROUTER      4
`define NUM_PIA_TO_LAB_ROUTERS          `LAB_COUNT
`define NUM_BITS_PIA_TO_LAB_ROUTING     (`NUM_PIA_TO_LAB_ROUTERS * `BITS_PER_PIA_TO_LAB_ROUTER)

/*
 * All global output enable signals are selected in sequence within the bitstream
 */
`define BITS_PER_OUTPUT_ENABLE          5
`define NUM_BITS_OUTPUT_ENABLE_CONFIG   (`NUM_GLOBAL_OUTPUT_ENABLE_SIGNALS * `BITS_PER_OUTPUT_ENABLE)


// TODO: Calculate total number of bits
// `define TOTAL_BIT_COUNT                 15033
`define TOTAL_BIT_COUNT                 (`NUM_BITS_PRODUCT_TERM_CONFIG + )

`endif
