
`ifndef DEVICE_SPECIFIC_PARAMETERS

`define BIT_COUNT                       15033
`define LAB_COUNT                       2
`define MACROCELLS_PER_LAB              16
`define MACROCELL_COUNT                 (`LAB_COUNT * `MACROCELLS_PER_LAB)
`define IO_COUNT                        32
`define DEDICATED_INPUT_COUNT           4
`define GLOBAL_CLOCK_COUNT              2
`define PIA_SIGNAL_COUNT                (`MACROCELL_COUNT + `IO_COUNT + `DEDICATED_INPUT_COUNT)
`define LAB_SIGNALS_FROM_PIA_COUNT      (`MACROCELL_COUNT + `DEDICATED_INPUT_COUNT)

`endif
