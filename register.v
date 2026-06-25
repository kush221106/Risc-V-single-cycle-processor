module register_file(output reg [31:0]RD1,RD2,input [4:0]A1,A2,A3,input [31:0]WD3,input WE3,clk);
reg [31:0] registers[31:0];
always@(posedge clk)
begin
if(WE3)
registers[A3]<=WD3;
end
always@(*)
begin 
RD1=registers[A1];
RD2=registers[A2];
end
endmodule