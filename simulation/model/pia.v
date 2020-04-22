
module programmable_interconnect_array
        #(
            parameter lab_count = 2,
            parameter io_pin_count = 32,
            parameter macrocell_count = 32,
            parameter dedicated_input_pin_count = 4,
            parameter pia_signal_count = 68
            )
        (
            input  [dedicated_input_pin_count-1:0]      dedicated_input_pin_signals,
            input  [io_pin_count-1:0]                   io_pin_signals,
            input  [macrocell_count-1:0]                macrocell_output_signals,

            output [pia_signal_count-1:0]               pia_signals
            );

// TODO

genvar i;
generate
    for (i=0; i<lab_count; i=i+1)
    begin
        assign pia_signals[pia_signal_count-1:pia_signal_count-i*32] = io_pin_signals[io_pin_count-1-(i*16):io_pin_count-(i+1)*16];
        assign pia_signals[pia_signal_count-16:pia_signal_count-15-i*32] = macrocell_output_signals[macrocell_count-1-(i*16):macrocell_count-(i+1)*16];
    end

    assign pia_signals[dedicated_input_pin_count-1:0] = dedicated_input_pin_signals[dedicated_input_pin_count-1:0];
endgenerate


endmodule
