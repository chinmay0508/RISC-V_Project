module top(
    input clk,
    input rst
);

//32 bit wire that connects the PC output to the Instruction Memory input 
wire [31:0] PC_IM;
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
    .instruction_out()
);
endmodule
