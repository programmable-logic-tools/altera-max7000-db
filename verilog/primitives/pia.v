
`ifndef PIA_H
`define PIA_H


/**
 * The programmable interconnect array (PIA) is fed by
 * all dedicated inputs, I/O pins and macrocell outputs.
 */
module programmable_interconnect_array
        #(
            parameter lab_count = 2,
            parameter num_io_pins = 32,
            parameter num_macrocells = 32,
            parameter num_dedicated_inputs = 4,
            parameter num_pia_signals = 68
            )
        (
            input  [num_dedicated_inputs-1:0]           dedicated_input_signals,
            input  [num_io_pins-1:0]                    io_pin_signals,
            input  [num_macrocells-1:0]                 macrocell_output_signals,

            output [num_pia_signals-1:0]                pia_signals
            );

    /*
     * The PIA does nothing more than forward the signals it is fed with to the device's LABs,
     * which in turn can be configured to select a subset of those signals as regional signals.
     */
    genvar i;
    generate
        for (i=0; i<lab_count; i=i+1)
        begin
            assign pia_signals[num_pia_signals-1:num_pia_signals-i*32] = io_pin_signals[num_io_pins-1-(i*16):num_io_pins-(i+1)*16];
            assign pia_signals[num_pia_signals-16:num_pia_signals-15-i*32] = macrocell_output_signals[num_macrocells-1-(i*16):num_macrocells-(i+1)*16];
        end

        assign pia_signals[num_dedicated_inputs-1:0] = dedicated_input_signals[num_dedicated_inputs-1:0];
    endgenerate

endmodule

`endif
