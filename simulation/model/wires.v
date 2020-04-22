
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
wire[159:0] product_term_results:
wire[15:0] expander_product_terms[0:1];

/*
 * Macrocell signals
 */
wire[31:0] macrocell_outputs;
