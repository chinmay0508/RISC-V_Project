`timescale 1ns/1ps

module PC_tb;

reg [31:0] pc_in;
reg clk;
reg rst;
wire [31:0] pc_out;

PC dut(
    .pc_in(pc_in),
    .clk(clk),
    .rst(rst),
    .pc_out(pc_out)
);

always #5 clk = ~clk;

initial 
begin
    $dumpfile("PC.vcd");
    $dumpvars(0,PC_tb);
    $monitor("Time=%0t | rst=%b | pc_in=%d | pc_out=%d", 
              $time, rst, pc_in, pc_out);

    clk = 0;
    rst = 1;
    pc_in = 32'd0;

    // Apply reset
    #10 rst = 0;

    // Apply different PC inputs
    #10 pc_in = 32'd4;
    #10 pc_in = 32'd8;
    #10 pc_in = 32'd12;
    #10 pc_in = 32'd16;

    // Apply reset again
    #10 rst = 1;
    #10 rst = 0;

    #20 $finish;
end


endmodule