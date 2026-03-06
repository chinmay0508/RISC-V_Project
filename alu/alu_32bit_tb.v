`timescale 1ns/1ps

module alu_32bit_tb;

reg [31:0] op_1_in, op_2_in;
reg [3:0] aluCtrl;
wire [31:0] result_out;

alu_32bit dut (
    .op_1_in(op_1_in),
    .op_2_in(op_2_in),
    .aluCtrl(aluCtrl),
    .result_out(result_out)
);

initial 
begin

$dumpfile("alu_32bit.vcd");
$dumpvars(0, alu_32bit_tb);


// AND
op_1_in = 32'hF0F0F0F0;
op_2_in = 32'h0F0F0F0F;
aluCtrl= 4'b0000;
#10;
$display("AND: %h & %h = %h", op_1_in, op_2_in, result_out);

// OR
aluCtrl= 4'b0001;
#10;
$display("OR: %h | %h = %h", op_1_in, op_2_in, result_out);

// ADD
op_1_in = 5; 
op_2_in = 3; 
aluCtrl= 4'b0010;
#10;
$display("ADD: %d + %d = %d", op_1_in, op_2_in, result_out);

// SLL
op_1_in = 1;
op_2_in = 5;
aluCtrl= 4'b0011;
#10;
$display("SLL: %h << %d = %h", op_1_in, op_2_in, result_out);

// XOR
op_1_in = 32'hAAAA5555;
op_2_in = 32'hFFFF0000;
aluCtrl = 4'b0100;
#10;
$display("XOR: %h ^ %h = %h", op_1_in, op_2_in, result_out);

// SRL
op_1_in = 32'h80000000;
op_2_in = 1;
aluCtrl= 4'b0101;
#10;
$display("SRL: %h >> %d = %h", op_1_in, op_2_in, result_out);

// SUB
op_1_in = 5; 
op_2_in = 3; 
aluCtrl= 4'b0110;
#10;
$display("SUB: %d - %d = %d", op_1_in, op_2_in, result_out);


// SLT
op_1_in = 32'hFFFFFFFF;
op_2_in = 1;
aluCtrl= 4'b0111;
#10;
$display("SLT: %h < %h = %d", op_1_in, op_2_in, result_out);

// SLTU
aluCtrl= 4'b1001;
#10;
$display("SLTU: %h < %h = %d", op_1_in, op_2_in, result_out);

// SRA
aluCtrl= 4'b1101;
#10;
$display("SRA: %h >>> %d = %h", op_1_in, op_2_in, result_out);

// LUI
op_1_in = 0;
op_2_in = 32'h12345000;
aluCtrl = 4'b1000;
#10;
$display("LUI: result = %h", result_out);

$finish;

end

endmodule