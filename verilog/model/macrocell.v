
module macrocell(
    input [12:0] configuration,

    input [4:0] product_term_results,
    input       global_clear,
    input [1:0] global_clocks,
    input input_from_io_pin,

    output expander_product_term_output,
    output macrocell_output
    );

/*
 * Product term select matrix
 */
wire[4:0] pt;
genvar i;
generate
    // OR gate inputs
    for (i=0; i<5; i=i+1)
        assign pt[i] = configuration[12-5+i] | product_term_results[i];
endgenerate
// OR gate output: Sum of products
wire sop = pt[0] | pt[1] | pt[2] | pt[3] | pt[4];

assign expander_product_term_output = product_term_results[4];

/*
 * Register
 */
wire selected_global_clock = configuration[0] ? global_clocks[0] : global_clocks[1];
wire clock = configuration[7] ? product_term_results[3] : selected_global_clock;

endmodule
