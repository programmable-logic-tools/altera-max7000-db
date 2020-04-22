/**
 * Logic array block:
 *  A subset of 36 signals selected from the PIA
 *  serving as input to a 16 macrocells
 */

module logic_array_block
        #(
            parameter pia_input_signal_count = 36,
            parameter expander_product_term_count = 16,
            parameter lab_signal_count = 2*pia_input_signal_count + expander_product_term_count
        )
        (
            /**
             * Signals routed to this LAB from the PIA
             */
            input  [pia_input_signal_count-1:0] selected_pia_signals,

            /**
             * Feedback signals from shared "expander" product terms
             */
            input  [expander_product_term_count-1:0] expander_product_terms,

            /**
             * All signals available to the macrocells in this LAB
             */
            output [lab_signal_count-1:0] lab_signals
        );

/*
 * Generate inverted signals
 */
wire[pia_input_signal_count-1:0] inverted_pia_signals;
for (i=0; i<pia_input_signal_count; i=i+1)
    assign inverted_pia_signals[i] = ~selected_pia_signals[i];

/*
 * Generate list of LAB signals
 */
for (i=0; i<pia_input_signal_count; i=i+1)
begin
    assign local_signals[lab_signal_count-1-(i*2)] = selected_pia_signals[i];
    assign local_signals[lab_signal_count-1-(i*2+1)] = inverted_pia_signals[i];
end
assign local_signals[expander_product_term_count-1:0] = expander_product_terms[expander_product_term_count-1:0];

endmodule
