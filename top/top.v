module top(
    input clk,
    input rst
);

// PC related
wire [31:0] pc_next;
wire [31:0] pc_plus4;
wire [31:0] pc_branch;

// register file wires
wire [31:0] readData1;
wire [31:0] readData2;
wire [31:0] writeData;

// immediate
wire [31:0] imm_out;

// ALU
wire [31:0] alu_in2;
wire [31:0] alu_result;
wire [3:0] aluCtrl_wire;

// memory
wire [31:0] read_data;

// control signals
wire regWrite;
wire ALUsrc;
wire memRead;
wire memWrite;
wire memToReg;
wire branch;
wire jump;
wire [2:0] ALUop;

// branch decision
wire PCsrc;

// instruction memory connection
wire [31:0] PC_IM;
wire [31:0] instr_top;

// instantiating the PC
PC PC(
    .pc_in(pc_next),
    .clk(clk),
    .rst(rst),
    .pc_out(PC_IM)
);

// instantiating the Instruction Memory
InstructionMemory InstructionMemory(
    .address_read(PC_IM),
    .instruction_out(instr_top)
);

// instantiating the ALU control
aluControl aluControl (
    .ALUop(ALUop),
    .funct3(instr_top[14:12]),
    .funct7_5(instr_top[30]),
    .aluCtrl(aluCtrl_wire)
);

// instantiating the ALU 
alu_32bit alu_32bit (
    .op_1_in(readData1),
    .op_2_in(alu_in2),
    .aluCtrl(aluCtrl_wire),
    .result_out(alu_result)
);

// instantiating the Register File 
registerFile registerFile(
    .clk(clk),
    .rst(rst),
    .rs1(instr_top[19:15]),
    .rs2(instr_top[24:20]),
    .rd(instr_top[11:7]),
    .regWrite(regWrite),
    .writeData(writeData),
    .readData1(readData1),
    .readData2(readData2)
); 

// instantiating the Immediate Generator
immediateGenerator immediateGenerator(
        .instr_in(instr_top),
        .immediate_instr(imm_out)
    );

// instantiating the Control Unit
controlUnit controlUnit (
    .opCode(instr_top[6:0]),
    .regWrite(regWrite),
    .ALUsrc(ALUsrc),
    .memRead(memRead),
    .memWrite(memWrite),
    .memToReg(memToReg),
    .branch(branch),
    .jump(jump),
    .ALUop(ALUop)
);

// instantiaing the Data Memory
dataMemory dataMemory(
    .clk(clk),
    .rst(rst),
    .memRead(memRead),
    .memWrite(memWrite),
    .Address(alu_result),
    .write_data(readData2),
    .read_data(read_data)
);

// instantiating the adder
adder pc_adder(
    .a(PC_IM),
    .b(32'd4),
    .y(pc_plus4)
);

// ALU SRC MUX
mux2to1 alu_mux(
    .a(readData2),
    .b(imm_out),
    .sel(ALUsrc),
    .y(alu_in2)
);

// WRITE BACK MUX
mux2to1 wb_mux(
    .a(alu_result),
    .b(read_data),
    .sel(memToReg),
    .y(writeData)
);

// BRANCH ADDER
adder branch_adder(
    .a(PC_IM),
    .b(imm_out),
    .y(pc_branch)
);


assign PCsrc = branch & (alu_result == 32'b0);


//
mux2to1 pc_mux(
    .a(pc_plus4),
    .b(pc_branch),
    .sel(PCsrc),
    .y(pc_next)
);
endmodule