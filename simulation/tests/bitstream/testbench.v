
module bitstream;

// parameter size = 15033;
parameter size = 6;

reg bitstream[size-1:0];

initial
begin
$readmemb("test.bit", bitstream);
end

integer i;
initial
for (i=0; i<size; i=i+1)
    $display(bitstream[i]);

endmodule
