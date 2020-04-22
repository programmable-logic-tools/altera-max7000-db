
module product_term
        #(
            parameter input_signal_count = 88
            )
        (
            input[input_signal_count-1:0] input_signals,
            input[input_signal_count-1:0] configuration,
            output output_signal;
            );

// $async$and$array(select, in, out);

wire[input_signal_count-1:0] intermediate_result;
assign intermediate_result[0] = input_signals[0];

genvar i;
generate
    for (i=1; i<input_signal_count; i=i+1)
        assign intermediate_result[i] = intermediate_result[i-1] & (input_signals[i] | configuration[i]);
endgenerate

assign output_signal = intermediate_result[input_signal_count-1];

endmodule
