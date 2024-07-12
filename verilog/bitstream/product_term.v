
`ifndef PRODUCT_TERM_DECODER_V
`define PRODUCT_TERM_DECODER_V


/**
 * Decodes the configuration bits for one product term
 * from the product term configuration block within a bitstream
 */
module product_term_configuration_decoder
        #(
            parameter lab = "A",
            parameter macrocell = 1,
            parameter product_term = 1,

            parameter num_labs = 2,
            parameter macrocells_per_lab = 16,
            parameter product_terms_per_macrocell = 5,
            parameter bits_per_product_term = 88,

            parameter bits_per_macrocell = product_terms_per_macrocell * bits_per_product_term,
            parameter bits_per_lab = macrocells_per_lab * bits_per_macrocell,
            parameter size_configuration_block = num_labs * bits_per_lab,
        )
        (
            input[num_input_signals-1:0] product_term_configuration_block,

            output[product_terms_per_macrocell-1:0] product_term_enable,
        );

    // Calculate offset within configuration block
    integer offset_lab = ($ord(lab) - $ord("A")) * bits_per_lab;
    integer offset_macrocell = offset_lab + (macrocell-1) * bits_per_macrocell;
    integer offset_product_term =  offset_macrocell + (product_term-1) * bits_per_product_term;

    // Note: An input signal is disabled when the configuration bit is 1, and enabled when its 0.
    genvar i;
    generate
        for (i=1; i<num_input_signals; i=i+1)
            assign product_term_enable[i] = !product_term_configuration_block[offset_product_term+i];
    endgenerate

endmodule

`endif
