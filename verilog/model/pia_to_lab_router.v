/**
 * Programmable interconnect array (PIA)
 *
 * This module selects signals from the PIA
 * and routes them to a LAB.
 * The PIA is capable of connecting any signals source
 * on the device with any destination.
 */

module pia_signal_selector
        #(
            parameter pia_signal_count = 68,
            parameter pia_to_lab_routing_bit_count = 144,
            parameter pia_to_lab_signal_count = 36
            )
        (
            input [pia_signal_count-1:0]                pia_signals,
            input [pia_to_lab_routing_bit_count-1:0]    configuration,
            output[pia_to_lab_signal_count-1:0]         pia_to_lab_signals
            );

// TODO

endmodule
