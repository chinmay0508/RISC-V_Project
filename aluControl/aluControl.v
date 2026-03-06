module aluControl(
    input [2:0] ALUop,       // From main Control Unit
    input [2:0] funct3,      // instruction[14:12]
    input funct7_5,          // instruction[30]
    output reg [3:0] aluCtrl // To ALU
);

    // funct3 parameters
    parameter FUNCT3_ADD  = 3'b000;
    parameter FUNCT3_SLL  = 3'b001;
    parameter FUNCT3_SLT  = 3'b010;
    parameter FUNCT3_SLTU = 3'b011;
    parameter FUNCT3_XOR  = 3'b100;
    parameter FUNCT3_SRL  = 3'b101;
    parameter FUNCT3_OR   = 3'b110;
    parameter FUNCT3_AND  = 3'b111;

    always @(*) begin
        case (ALUop)

            // Load / Store / JALR
            3'b000: aluCtrl = 4'b0010;   // ADD

            // Branch
            3'b001: aluCtrl = 4'b0110;   // SUB

            // R-type and I-type arithmetic
            3'b010: begin
                case (funct3)

                    FUNCT3_ADD: begin
                        if (funct7_5)
                            aluCtrl = 4'b0110; // SUB
                        else
                            aluCtrl = 4'b0010; // ADD
                    end

                    FUNCT3_AND: aluCtrl = 4'b0000; // AND

                    FUNCT3_OR:  aluCtrl = 4'b0001; // OR

                    FUNCT3_SLT: aluCtrl = 4'b0111; // SLT

                    FUNCT3_SLTU: aluCtrl = 4'b1001; // SLTU

                    FUNCT3_XOR: aluCtrl = 4'b0100; // XOR

                    FUNCT3_SLL: aluCtrl = 4'b0011; // SLL

                    FUNCT3_SRL: begin
                        if (funct7_5)
                            aluCtrl = 4'b1101; // SRA
                        else
                            aluCtrl = 4'b0101; // SRL
                    end

                    default: aluCtrl = 4'b1111;

                endcase
            end

            // LUI
            3'b100: aluCtrl = 4'b1000;

            default: aluCtrl = 4'b0010;

        endcase
    end

endmodule