module registerFile(
    input clk,
    input rst,         // sync reset 
    input [4:0] rs1,   // 5 bit source register 1
    input [4:0] rs2,   // 5 bit source register 2
    input [4:0] rd,    // 5 bit destination register 
    input regWrite,    // Register write enable signal
    input [31:0] writeData, // Data to be written into destination register
    output [31:0] readData1,// Data read from source register 1
    output [31:0] readData2 // Data read from source register 2
);
// 32 registers with 32 bit width 
reg [31:0] registers[0:31];

// x0 should always read as 0 (RISC-V spec)
assign readData1 = (rs1 == 0) ? 32'b0 : registers[rs1];
assign readData2 = (rs2 == 0) ? 32'b0 : registers[rs2];

integer i;
always @ (posedge clk)
begin
    if(rst)
    begin
        for(i = 0; i < 32 ; i=i+1)
        begin
            registers[i] <= 32'h0;
        end
    end
    else if(regWrite && rd!=5'd0) // Only write if regWrite is high AND destination is not x0 
    begin
        registers[rd] <= writeData ;
    end
end
endmodule