module controlUnit(
    input [6:0] opCode,
    output reg regWrite,
    output reg ALUsrc,
    output reg memRead,
    output reg memWrite,
    output reg memToReg,
    output reg branch,
    output reg jump,
    output reg [2:0] ALUop
);
always @ (*)
begin
    regWrite = 1'b0;
    ALUsrc = 1'b0;
    memRead = 1'b0;
    memWrite = 1'b0;
    memToReg = 1'b0;
    branch = 1'b0;
    jump = 1'b0;
    ALUop = 3'b000;
    case (opCode)
    7'b0110011 :                 // R type 
    begin
        regWrite = 1'b1;
        ALUop = 3'b010;
    end
    7'b0010011 :                 // I Type
    begin
        regWrite = 1'b1;
        ALUsrc = 1'b1;
        ALUop = 3'b010;
    end
    7'b0000011 :                 // Load type 
    begin
        regWrite = 1'b1;
        ALUsrc = 1'b1;
        memRead = 1'b1;
        memToReg = 1'b1;
    end
    7'b0100011 :                 // Store type 
    begin
        ALUsrc = 1'b1;
        memWrite = 1'b1;
        memToReg = 1'b0;         // memToReg = 1'bx
    end
    7'b1100011 :                 // Branch type
    begin
        memToReg = 1'b0;         // memToReg = 1'bx
        branch = 1'b1;
        ALUop = 3'b001;
    end
    7'b1101111 :                 // JAL Type
    begin
        regWrite = 1'b1;
        ALUsrc = 1'b0;           // ALUrsc = 1'bx
        jump = 1'b1;
        ALUop = 3'b000;          // ALUop = 3'bxxx
    end
    7'b1100111 :                 // JALR Type
    begin
        regWrite = 1'b1;
        ALUsrc = 1'b1;
        jump = 1'b1;
    end
    7'b0110111 :                 // LUI Type
    begin
        regWrite = 1'b1;
        ALUsrc = 1'b1;
        ALUop = 3'b100;
    end
    7'b0010111 :                 // AUIPC Type
    begin
        regWrite = 1'b1;
        ALUsrc = 1'b1;
    end
    7'b1110011 :                 // System Type
    begin
        ALUop = 3'b000;          // ALUop = 3'bxxx
    end
    default : ;
    endcase 
end
endmodule
