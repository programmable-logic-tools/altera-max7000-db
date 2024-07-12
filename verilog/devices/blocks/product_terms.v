
/*
 * Product terms
 */
integer l;
generate
    for (i=0; i<160; i=i+1)
    begin
        // The input signals are the same for all product terms of one LAB.
        l = i % (16*5);
        assign product_term_inputs[i][87:0] = lab_signals[l][87:0];

        product_term #(
                .num_input_signals(88)
            )
            pt (
                .input_signals  (product_term_inputs[i][87:0]),
                .configuration  (bitstream_product_terms[i][87:0]),
                .output_signal  (sum_of_products[i])
                );
    end
endgenerate
