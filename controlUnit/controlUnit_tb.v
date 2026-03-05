`timescale 1ns/1ps
module controlUnit_tb;
reg [6:0] opCode;
wire regWrite;
wire ALUsrc;
wire memRead;
wire memWrite;
wire memToReg;
wire branch;
wire jump;
wire [2:0] ALUop;
controlUnit dut (
    .opCode(opCode),
    .regWrite(regWrite),
    .ALUsrc(ALUsrc),
    .memRead(memRead),
    .memWrite(memWrite),
    .memToReg(memToReg),
    .branch(branch),
    .jump(jump),
    .ALUop(ALUop)
);

initial begin
$dumpfile("controlUnit.vcd");
$dumpvars(0,controlUnit_tb);
$display("Opcode   regWrite ALUsrc memRead memWrite memToReg branch jump ALUop");

// R type
opCode = 7'b0110011; #10;

// I type
opCode = 7'b0010011; #10;

// Load
opCode = 7'b0000011; #10;

// Store
opCode = 7'b0100011; #10;

// Branch
opCode = 7'b1100011; #10;

// JAL
opCode = 7'b1101111; #10;

// JALR
opCode = 7'b1100111; #10;

// LUI
opCode = 7'b0110111; #10;

// AUIPC
opCode = 7'b0010111; #10;

// System
opCode = 7'b1110011; #10;

$finish;

end

// monitor changes
initial begin
$monitor("%b   %b %b %b %b %b %b %b %b",
        opCode, regWrite, ALUsrc, memRead,
        memWrite, memToReg, branch, jump, ALUop);
end

endmodule