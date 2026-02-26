module top(
    input clk,
    input rst
);

//32 bit wire that connects the PC output to the Instruction Memory input 
wire [31:0] PC_IM, instr_top;
// instantiating the PC
PC PC(
    .pc_in(),
    .clk(clk),
    .rst(rst),
    .pc_out(PC_IM)
);

// instantiating the Instruction Memory
InstructionMemory InstructionMemory(
    .address_read(PC_IM),
    .instruction_out(instr_top)
);

// instantiating the Register File 
registerFile registerFile(
    .clk(clk),
    .rst(rst),
    .rs1(instr_top[19:15]),
    .rs2(instr_top[24:20]),
    .rd(instr_top[11:7]),
    .regWrite(),
    .writeData(),
    .readData1(),
    .readData2(),
);

// instantiating the Immediate Generator
immediateGenerator immediateGenerator(
        .instr_in(instr_top),
        .immediate_instr()
    );

endmodule
