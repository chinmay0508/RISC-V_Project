`timescale 1ns/1ps

module aluControl_tb;

reg [2:0] ALUop;
reg [2:0] funct3;
reg funct7_5;

wire [3:0] aluCtrl;

aluControl dut (
    .ALUop(ALUop),
    .funct3(funct3),
    .funct7_5(funct7_5),
    .aluCtrl(aluCtrl)
);

initial begin

$dumpfile("aluControl.vcd");
$dumpvars(0, aluControl_tb);

// Load / Store (ADD)
ALUop = 3'b000; funct3 = 3'b000; funct7_5 = 0;
#10;
$display("LOAD/STORE : aluCtrl = %b (ADD expected)", aluCtrl);

// Branch (SUB)
ALUop = 3'b001; funct3 = 3'b000; funct7_5 = 0;
#10;
$display("BRANCH : aluCtrl = %b (SUB expected)", aluCtrl);

// ADD
ALUop = 3'b010; funct3 = 3'b000; funct7_5 = 0;
#10;
$display("ADD : aluCtrl = %b", aluCtrl);

// SUB
ALUop = 3'b010; funct3 = 3'b000; funct7_5 = 1;
#10;
$display("SUB : aluCtrl = %b", aluCtrl);

// AND
ALUop = 3'b010; funct3 = 3'b111; funct7_5 = 0;
#10;
$display("AND : aluCtrl = %b", aluCtrl);

// OR
ALUop = 3'b010; funct3 = 3'b110; funct7_5 = 0;
#10;
$display("OR : aluCtrl = %b", aluCtrl);

// XOR
ALUop = 3'b010; funct3 = 3'b100; funct7_5 = 0;
#10;
$display("XOR : aluCtrl = %b", aluCtrl);

// SLL
ALUop = 3'b010; funct3 = 3'b001; funct7_5 = 0;
#10;
$display("SLL : aluCtrl = %b", aluCtrl);

// SRL
ALUop = 3'b010; funct3 = 3'b101; funct7_5 = 0;
#10;
$display("SRL : aluCtrl = %b", aluCtrl);

// SRA
ALUop = 3'b010; funct3 = 3'b101; funct7_5 = 1;
#10;
$display("SRA : aluCtrl = %b", aluCtrl);

// SLT
ALUop = 3'b010; funct3 = 3'b010; funct7_5 = 0;
#10;
$display("SLT : aluCtrl = %b", aluCtrl);

// SLTU
ALUop = 3'b010; funct3 = 3'b011; funct7_5 = 0;
#10;
$display("SLTU : aluCtrl = %b", aluCtrl);

// LUI
ALUop = 3'b100; funct3 = 3'b000; funct7_5 = 0;
#10;
$display("LUI : aluCtrl = %b", aluCtrl);

$finish;

end

endmodule