/*
 * Logic Array Blocks
 */
generate
    for (i=0; i<`LAB_COUNT; i=i+1)
    begin
        logic_array_block lab(
                .selected_pia_signals   (pia_to_lab_signals[i][35:0]),
                .expander_product_terms (expander_product_terms[i][15:0]),
                .lab_signals            (lab_signals[i][87:0])
                );
    end
endgenerate
