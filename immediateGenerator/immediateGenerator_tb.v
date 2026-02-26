`timescale 1ns/1ps

module immediateGenerator_tb;

    reg  [31:0] instr_in;
    wire [31:0] immediate_instr;

    immediateGenerator dut (
        .instr_in(instr_in),
        .immediate_instr(immediate_instr)
    );

    initial begin
        $display("Time\tInstruction\t\tImmediate");
        $monitor("%0t\t%h\t%h", $time, instr_in, immediate_instr);

        instr_in = 32'b0000000_00011_00010_000_00001_0110011; // R type (add x1,x2,x3)
        #10;

        instr_in = 32'b000000000010_00010_000_00001_0010011; //I type (addi x1,x2,10)
        #10;

        instr_in = 32'b0000000_00001_00010_010_01000_0100011; //S type (sw x1, 8(x2))
        #10;

        instr_in = 32'b0000000_00010_00001_000_01000_1100011; //B type (beq x1,x2,offset)
        #10;

        instr_in = 32'b00010010001101000101_00001_0110111; //U type (lui x1, 0x12345)
        #10;

        instr_in = 32'b00000000001000000000_00001_1101111; //J type (jal x1, 32)
        #10;
        $finish;
    end
endmodule