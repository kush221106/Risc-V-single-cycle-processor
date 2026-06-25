`include "data_path.v"
`include "control_path.v"
`include "memory.v"
`include "register.v"
module top(input clk,reset);
wire Zero,PCSrc,AluSrc,RegWrite,MemWrite;
wire [4:0]A1,A2,A3;
wire [2:0]AluControl;
wire [31:0]WriteData,AluResult,RD1,RD2,Instr,ReadData,WD3,Pc;
wire [1:0]ResultSrc,ImmSrc;
datapath dp(Zero,A1,A2,A3,WD3,Pc,WriteData,AluResult,clk,PCSrc,AluSrc,reset,ResultSrc,ImmSrc,AluControl,RD1,RD2,Instr,ReadData);
controlpath cp( PCSrc,MemWrite,AluSrc,RegWrite, ResultSrc,ImmSrc,AluControl,Instr,Zero);
instruction_memory im( Instr,Pc);
data_memory dm(ReadData,AluResult,WriteData,MemWrite,clk);
register_file rf( RD1,RD2,A1,A2,A3,WD3, RegWrite,clk);
endmodule 