
// `include "product_term.v"


module testbench;

// parameter size = 15033;
parameter size = 6;

// reg[size-1:0] testdata = size'b001100;

reg bitstream[size-1:0];

initial
begin
$readmemb("test.bit", bitstream);
end

integer i;
initial
for (i=0; i<size; i=i+1)
    $display(bitstream[i]);

// product_term pt0
//     #(
//         .size(size)
//     )
//     (
//         .
//     );

reg[5:0] in = 0;
reg out = 0;
wire[5:0] conf;

// task $async$and$array()
// begin
// end

genvar j;
for (j=0; j<size; j=j+1)
    assign conf[j] = bitstream[j];

initial #1
begin
$async$and$array(conf, in, out);
end

endmodule
