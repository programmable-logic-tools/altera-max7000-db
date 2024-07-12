
`ifndef PRODUCT_TERM_V
`define PRODUCT_TERM_V


/**
 * Model of a MAX7000(S/E) product term
 */
module product_term
        #(
            /**
             * Number of regional signals within a LAB:
             * 36 signals from the PIA (inverted & non-inverted) plus
             * 16 shared expander signals from the LAB's macrocells
             */
            parameter num_input_signals = 88
        )
        (
            // Control
            input[num_input_signals-1:0] product_term_enable,

            // Logic
            input[num_input_signals-1:0] input_signals,
            output output_signal;
        );

    // $async$and$array(select, in, out);

    /*
     * Note: A product outputs true, when the previous product (if any) outputs true (1), and, the current signal is true (1) or disabled (0).
     * Truth table:
     * true/1,  enabled/1  => true
     * false/0, enabled/1  => false
     * true/1,  disabled/0 => true
     * false/0, disabled/0 => true
     */

    wire[num_input_signals-1:0] intermediate_result;
    assign intermediate_result[0] = input_signals[0] | !product_term_enable[i];

    genvar i;
    generate
        for (i=1; i<num_input_signals; i=i+1)
            assign intermediate_result[i] = intermediate_result[i-1] & (input_signals[i] | !product_term_enable[i]);
    endgenerate

    assign output_signal = intermediate_result[num_input_signals-1];

endmodule

`endif
