
/*
 * Macrocells
 */
generate
    for (i=0; i<num_macrocells; i=i+1)
    begin
        macrocell mc(
            .configuration          (bitstream_macrocells[i][12:0]),

            .sum_of_products   (sum_of_products[160-1-i*5:160-(i+1)*5]),

            .global_clear           (global_clear),
            .global_clocks          (global_clocks[1:0]),
            // TODO: That's arbitrary...
            // .input_from_io_pin      (pin)

            // .expander_product_term_output(),
            .macrocell_output       (macrocell_outputs[i])
            );
    end
endgenerate
