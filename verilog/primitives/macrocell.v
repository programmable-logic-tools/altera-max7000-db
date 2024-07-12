
`ifndef MACROCELL_V
`define MACROCELL_V

/**
 *
 */
module macrocell_configuration_decoder
        #(

        )
        (

        );
endmodule


/**
 * Models the behaviour of a macrocell,
 * not including product terms
 *
 * See also: device family datasheet, page 9
 */
module macrocell
        #(
            parameter num_lab_signals = 2*36 + 16,
            parameter num_product_terms = 5
        )
        (
            // Configuration bits for the macrocell logic
            input [12:0] config_macrocell,

            // Configuration bits for product terms
            input [5*num_input_signals-1:0] config_product_terms,

            // input       global_clear,
            // input [1:0] global_clocks,

            input       preset,
            input       clock,
            input       clear,
            input       parallel_expander_in,

            input       from_io_pin,
            output      shared_expander_out,
            output      parallel_expander_out,
            output      to_pia,
            output      to_io_control_block;
        );

    /*
     * Macrocell configuration bits
     */

    /*
     * Note:
     * When the configuration bit is 0, the respective product term is connected
     * to the OR gate, and disconnected i.e. disregarded when its 1.
     */
    wire product_term_enable[4:0] = config_macrocell[12-5+i];

    /*
     * Product term instances
     */
    wire[4:0] sum_of_products;
    genvar i;
    generate
        for (i=0; i<5; i=i+1)
        begin
            // product_term()
            // TODO
        end
    endgenerate

    /*
     * Parallel logic expanders (from other macrocells)
     */
    // TODO

    /*
     * Product term select matrix
     */
    // wire[4:0] pt;
    // generate
    //     // OR gate inputs
    //     for (i=0; i<5; i=i+1)
    //         assign pt[i] = ;
    // endgenerate

    // Sum of products
    wire sop = pt[0] | pt[1] | pt[2] | pt[3] | pt[4];

    // ?
    assign expander_product_term_output = sum_of_products[4];

    /*
    * Register
    */
    wire selected_global_clock = config_macrocell[0] ? global_clocks[0] : global_clocks[1];
    wire clock = config_macrocell[7] ? sum_of_products[3] : selected_global_clock;

    /*
     * Shareable logic expander
     */
    // TODO

endmodule

`endif
