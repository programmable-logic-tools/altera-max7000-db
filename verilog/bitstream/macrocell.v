
`ifndef MACROCELL_CONFIG_V
`define MACROCELL_CONFIG_V


/**
 * Decodes the configuration bits for a macrocell
 * from the macrocell configuration block within a bitstream
 */
module macrocell_configuration_decoder
        #(
            parameter lab = "A",
            parameter macrocell = 1,

            parameter num_labs = 2,
            parameter macrocells_per_lab = 16,
            parameter product_terms_per_macrocell = 5,

            parameter bits_per_macrocell = 13,
            parameter bits_per_lab = macrocells_per_lab * bits_per_macrocell,
            parameter size_configuration_block = num_labs * bits_per_lab,
        )
        (
            input[size_configuration_block-1:0] macrocell_configuration_block,

            output[product_terms_per_macrocell-1:0] product_term_enable,
            output                                  clear_select,
            output                                  enable_preset, // possibly?
            output[1:0]                             clock_and_enable_switch,
            output                                  fast_input_select,  // from I/O pin
            output[2:0]                             parallel_expander_enable, // possibly?
            output                                  register_bypass_enable;
        );

    // TODO

endmodule

`endif
