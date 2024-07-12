/**
 * Behavioural model of the Altera EPM7032S CPLD
 */

`include "io.v"
`include "pia.v"
`include "lab.v"
`include "product_term.v"
`include "macrocell.v"


module altera_max7000s(
        /**
        * The devices pins
        */
        inout[31:0] io_pins,
        input[3:0] dedicated_inputs,

        /**
         * Device configuration
         */
        input[`TOTAL_BIT_COUNT-1:0] bitstream
    );


    /*
    * Bitstream partitioning
    */
    wire[87:0] bitstream_product_terms[0:159];
    wire[12:0] bitstream_macrocells[0:31];


    wire global_clear;
    wire[1:0] global_clocks;

    /*
    * PIA and LAB signals
    */
    wire[67:0] pia_signals;
    wire[35:0] pia_to_lab_signals[0:1];
    wire[87:0] lab_signals[0:1];

    /*
    * Product term signals
    */
    wire[87:0] product_term_inputs[0:159]
    wire[159:0] sum_of_products:
    wire[15:0] expander_product_terms[0:1];

    /*
    * Macrocell signals
    */
    wire[31:0] macrocell_outputs;


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
        .num_io_pins(32),
        .num_macrocells(32),
        .num_dedicated_inputs(4),
        .num_pia_signals(68)
    )
    pia (
// TODO
        );

pia_signal_selector #(
        .num_pia_signals(68),
        .pia_to_lab_routing_bit_count(144),
        .pia_to_lab_signal_count(36)
        )
    pia_to_lab_a(

        );





endmodule
