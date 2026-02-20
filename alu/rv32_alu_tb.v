`timescale 1ns/1ps

module tb_rv32_alu;

    reg [31:0] op_1_in, op_2_in;
    reg [2:0]  funct3;
    wire [31:0] result_out;

    // Instantiate the ALU
    rv32_alu uut (
        .op_1_in(op_1_in),
        .op_2_in(op_2_in),
        .funct3(funct3),
        .result_out(result_out)
    );

    // Helper task to check result
    task check;
        input [31:0] expected;
        begin
            #1; // wait a delta cycle
            if(result_out !== expected)
                $display("ERROR: op1=%h op2=%h opcode=%b result=%h expected=%h", op_1_in, op_2_in, opcode_in, result_out, expected);
            else
                $display("PASS: op1=%h op2=%h opcode=%b result=%h", op_1_in, op_2_in, opcode_in, result_out);
        end
    endtask

    initial begin
        $display("Starting RV32 ALU Testbench");

        // ------------------- ADD -------------------
        op_1_in = 32'h00000005; op_2_in = 32'h00000003; opcode_in = 4'b0000; // ADD
        check(32'h00000008);

        // ------------------- SUB -------------------
        op_1_in = 32'h00000005; op_2_in = 32'h00000003; opcode_in = 4'b1000; // SUB (opcode[3]=1 triggers subtraction)
        check(32'h00000002);

        // ------------------- AND -------------------
        op_1_in = 32'hF0F0F0F0; op_2_in = 32'h0F0F0F0F; opcode_in = 4'b0111;
        check(32'h00000000);

        // ------------------- OR -------------------
        op_1_in = 32'hF0F0F0F0; op_2_in = 32'h0F0F0F0F; opcode_in = 4'b0110;
        check(32'hFFFFFFFF);

        // ------------------- XOR -------------------
        op_1_in = 32'hAAAA5555; op_2_in = 32'h5555AAAA; opcode_in = 4'b0100;
        check(32'hFFFFFFFF);

        // ------------------- SLL -------------------
        op_1_in = 32'h00000001; op_2_in = 32'h00000005; opcode_in = 4'b0001;
        check(32'h00000020);

        // ------------------- SRL -------------------
        op_1_in = 32'h80000000; op_2_in = 32'h00000001; opcode_in = 4'b0101; // logical shift
        check(32'h40000000);

        // ------------------- SRA -------------------
        op_1_in = 32'h80000000; op_2_in = 32'h00000001; opcode_in = 4'b1101; // arithmetic shift
        check(32'hC0000000);

        // ------------------- SLT (signed) -------------------
        op_1_in = 32'hFFFFFFFF; op_2_in = 32'h00000001; opcode_in = 4'b0010; // -1 < 1
        check(32'h00000001);

        op_1_in = 32'h00000005; op_2_in = 32'h00000003; opcode_in = 4'b0010; // 5 < 3
        check(32'h00000000);

        // ------------------- SLTU (unsigned) -------------------
        op_1_in = 32'hFFFFFFFF; op_2_in = 32'h00000001; opcode_in = 4'b0011; // 4294967295 < 1 ? false
        check(32'h00000000);

        op_1_in = 32'h00000005; op_2_in = 32'h00000003; opcode_in = 4'b0011; // 5 < 3 ? false
        check(32'h00000000);

        $display("RV32 ALU Testbench Complete");
        $stop;
    end

endmodule