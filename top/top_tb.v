`timescale 1ns/1ps

module top_tb;

reg clk;
reg rst;

// instantiate TOP processor
top DUT (
    .clk(clk),
    .rst(rst)
);

//  clock generation (10ns period)
always #5 clk = ~clk;

initial 
begin
    $dumpfile("top.vcd");
    $dumpvars(0, top_tb);
    //  initial values
    clk = 0;
    rst = 1;

    //  apply reset for few cycles
    #20;
    rst = 0;

    //  run processor
    #1000;

    $finish;
end



endmodule









