/**
 * Altera MAX7032S CPLD model
 */

`include "epm7032s.vh"
`include "io.v"
`include "pia.v"
`include "lab.v"
`include "product_term.v"
`include "macrocell.v"


module epm7032s(
    /**
     * The devices pins
     */
    inout[31:0] io_pins,
    input[3:0] dedicated_inputs,

    /**
     * Device configuration
     */
    input[15032:0] bitstream
    );


`include "wires.v"

/*
 * Bitstream partitioning
 */
genvar i;
generate
    localparam bitstream_offset_product_terms = 15033;
    for (i=0; i<160; i=i+1)
        assign bitstream_product_terms[i][87:0] = bitstream[bitstream_offset_product_terms-1-(i*88):bitstream_offset_product_terms-(i+1)*88];

    localparam bitstream_offset_macrocells = bitstream_offset_product_terms - 2*16*5*(2*36+16);
    for (i=0; i<32; i=i+1)
        assign bitstream_macrocells[i][12:0] = bitstream[bitstream_offset_macrocells-1-i*13:bitstream_offset_macrocells-(i*1)*13];
endgenerate

/*
 * PIA
 */
programmable_interconnect_array #(
        .lab_count(2),
        .io_pin_count(32),
        .macrocell_count(32),
        .dedicated_input_pin_count(4),
        .pia_signal_count(68)
    )
    pia (
// TODO
        );

pia_signal_selector #(
        .pia_signal_count(68),
        .pia_to_lab_routing_bit_count(144),
        .pia_to_lab_signal_count(36)
        )
    pia_to_lab_a(

        );

/*
 * Logic Array Blocks
 */
generate
    for (i=0; i<2; i=i+1)
    begin
        logic_array_block lab(
                .selected_pia_signals   (pia_to_lab_signals[i][35:0]),
                .expander_product_terms (expander_product_terms[i][15:0]),
                .lab_signals            (lab_signals[i][87:0])
                );
    end
endgenerate

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
                .input_signal_count(88)
            )
            pt (
                .input_signals  (product_term_inputs[i][87:0]),
                .configuration  (bitstream_product_terms[i][87:0]),
                .output_signal  (product_term_results[i])
                );
    end
endgenerate

/*
 * Macrocells
 */
generate
    for (i=0; i<macrocell_count; i=i+1)
    begin
        macrocell mc(
            .configuration          (bitstream_macrocells[i][12:0]),

            .product_term_results   (product_term_results[160-1-i*5:160-(i+1)*5]),

            .global_clear           (global_clear),
            .global_clocks          (global_clocks[1:0]),
            // TODO: That's arbitrary...
            // .input_from_io_pin      (pin)

            // .expander_product_term_output(),
            .macrocell_output       (macrocell_outputs[i])
            );
    end
endgenerate


/*
 * Input/output pins
 */
// for (i=0; i<32; i=i+1)
// begin
//     io io_instance();
// end

endmodule
