module instruction_memory(output reg[31:0]instr,input [31:0]Pc);
reg [7:0] momory[255:0];
always@(*)
instr={momory[Pc],momory[Pc+1],momory[Pc+2],momory[Pc+3]};
endmodule
module data_memory(output reg [31:0]read_data,input [31:0]A,input [31:0]WD,input MemWrite,clk);
reg [31:0]momory[255:0];
always@(posedge clk)
begin 
if(MemWrite)
momory[A]<=WD;
end
always@(*)
begin
if(!MemWrite)
read_data=momory[A];
end
endmodule