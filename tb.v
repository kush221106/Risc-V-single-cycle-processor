`include "top_module.v"
module test;
reg clk,reset;
initial clk=0;
top tp(clk,reset);
always #5 clk=~clk;
initial 
begin
tp.im.momory[0]=8'b11111111;
tp.im.momory[1]=8'b11000100;
tp.im.momory[2]=8'b10100011;
tp.im.momory[3]=8'b00000011;
{tp.im.momory[4],tp.im.momory[5],tp.im.momory[6],tp.im.momory[7]}=32'h0064A423;
{tp.im.momory[8],tp.im.momory[9],tp.im.momory[10],tp.im.momory[11]}=32'h0062E233;
{tp.im.momory[12],tp.im.momory[13],tp.im.momory[14],tp.im.momory[15]}=32'hFE420AE3;
tp.rf.registers[9]=32'd100;
tp.rf.registers[5]=32'd10;
tp.dm.momory[96]=32'd20;
$monitor("%h %h %d",tp.dm.momory[108],tp.rf.registers[6],tp.rf.registers[4]);
end
initial 
begin 
reset =1;
#11 reset=0;
end
initial 
begin 
$dumpfile("test.vcd");
$dumpvars(0,test);
#50 $finish;
end
endmodule