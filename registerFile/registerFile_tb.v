`timescale 1ns/1ps

module tb_registerFile;

    reg clk;
    reg rst;
    reg [4:0] rs1, rs2, rd;
    reg regWrite;
    reg [31:0] writeData;
    wire [31:0] readData1, readData2;

    // Instantiate the register file
    registerFile uut (
        .clk(clk),
        .rst(rst),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .regWrite(regWrite),
        .writeData(writeData),
        .readData1(readData1),
        .readData2(readData2)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // ------------------- Test Case -------------------
        $display("Starting Register File Testbench");

        // Initialize
        rst = 1;
        regWrite = 0;
        rs1 = 0; rs2 = 0; rd = 0; writeData = 0;

        #10;         // wait one clock
        rst = 0;     // release reset

        // ------------------- Test 1: Write to x1 and read -------------------
        rd = 5'd1;
        writeData = 32'hA5A5A5A5;
        regWrite = 1;
        #10;         // wait one clock to write

        // Read back
        rs1 = 5'd1;
        rs2 = 5'd0;  // x0 should always read 0
        #1;          // small delay for combinational read
        $display("Read x1: %h, Read x0: %h", readData1, readData2);

        // ------------------- Test 2: Write to x2 and read -------------------
        rd = 5'd2;
        writeData = 32'h12345678;
        #10;         // wait one clock to write

        rs1 = 5'd1;  // read x1
        rs2 = 5'd2;  // read x2
        #1;
        $display("Read x1: %h, Read x2: %h", readData1, readData2);

        // ------------------- Test 3: Try writing to x0 (should be ignored) -------------------
        rd = 5'd0;
        writeData = 32'hFFFFFFFF;
        #10;
        rs1 = 5'd0;
        #1;
        $display("Read x0 after write attempt: %h", readData1);

        // ------------------- Finish -------------------
        $display("Register File Testbench Complete");
        $stop;
    end

endmodule