`timescale 1ns/1ps

module dataMemory_tb;

reg clk;
reg rst;
reg memRead;
reg memWrite;
reg [31:0] Address;
reg [31:0] write_data;
wire [31:0] read_data;

dataMemory dut(
    .clk(clk),
    .rst(rst),
    .memRead(memRead),
    .memWrite(memWrite),
    .Address(Address),
    .write_data(write_data),
    .read_data(read_data)
);

always #5 clk = ~clk;

initial
begin
$dumpfile("dataMemory.vcd");
$dumpvars(0,dataMemory_tb);

clk = 0;
rst = 1;
memRead = 0;
memWrite = 0;

#10;
rst = 0;
// WRITE TEST
Address = 32'd4;
write_data = 32'd100;
memWrite = 1;
#10;

memWrite = 0;

// READ TEST
memRead = 1;
Address = 32'd4;
#10;

$display("Read Data = %d", read_data); //32'd100


// SECOND WRITE
Address = 32'd8;
write_data = 32'd55;
memWrite = 1;
#10;

memWrite = 0;

// SECOND READ
Address = 32'd8;
#10;

$display("Read Data = %d", read_data); // 32'd55

#20;
$finish;

end

endmodule