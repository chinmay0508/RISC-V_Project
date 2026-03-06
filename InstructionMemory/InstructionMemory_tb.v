`timescale 1ns/1ps

module InstructionMemory_tb;

reg [31:0] address_read;
wire [31:0] instruction_out;

InstructionMemory dut(
    .address_read(address_read),
    .instruction_out(instruction_out)
);

initial
begin
    $dumpfile("InstructionMemory.vcd");
    $dumpvars(0, InstructionMemory_tb);
    $monitor("Time=%0t | address=%d | instruction=%b",
              $time, address_read, instruction_out);

    // Test different addresses
    address_read = 32'd0;
    #10;

    address_read = 32'd4;
    #10;

    address_read = 32'd8;
    #10;

    address_read = 32'd12;
    #10;

    address_read = 32'd16;
    #10;

    $finish;
end

endmodule