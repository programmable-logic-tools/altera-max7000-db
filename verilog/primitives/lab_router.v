
`ifndef PIA_ROUTER_V
`define PIA_ROUTER_V


/**
 * Selects the subset of PIA signals
 * to be routed to a LAB.
 */
module lab_router
        #(
            parameter num_pia_signals = 68,
            parameter pia_to_lab_routing_bit_count = 144,
            parameter pia_to_lab_signal_count = 36
        )
        (
            input [num_pia_signals-1:0]                pia_signals,
            input [pia_to_lab_routing_bit_count-1:0]    configuration,
            output[pia_to_lab_signal_count-1:0]         pia_to_lab_signals
        );

// TODO

endmodule

`endif
