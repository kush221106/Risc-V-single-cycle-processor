module adder(output reg[31:0]out,input [31:0]in1,in2);
always@(*)
out=in1+in2;
endmodule
module mux(output reg[31:0]out,input [31:0]in1,in2,input sel);
always@(*)
begin
case(sel)
1:out=in2;
0:out=in1;
default:out=in1;
endcase
end
endmodule
module signextent(output reg[31:0]out,input [31:0]in,input[1:0] immscr);
always@(*)
begin 
case(immscr)
0:out={{20{in[31]}},in[31:20]};
1:out={{20{in[31]}},in[31:25],in[11:7]};
2:out={{20{in[31]}},in[7],in[30:25],in[11:8],1'b0};
3:out={{20{in[31]}},in[19:12],in[20],in[30:21],1'b0};
default:out=32'dx;
endcase
end
endmodule
module mmux(output reg[31:0]out,input [31:0]in0,in1,in2,input [1:0]sel);
always@(*)
begin 
case(sel)
00:out=in0;
01:out=in1;
10:out=in2;
default:out=31'dx;
endcase
end
endmodule
module register(output reg[31:0] out,input [31:0]in,input reset,clk);
always@(posedge clk)
begin
    if(reset)
    out<=32'd0;
    else 
    out<=in;
end
endmodule
module alu(output reg[31:0]out,output zero,input [31:0]A,B,input [2:0]Alu_control);
always@(*)
begin 
case(Alu_control)
0:out=A+B;
1:out=A-B;
5:out=A<B;
3:out=A|B;
2:out=A&B;
default:out=32'dx;
endcase
end
assign zero=~|out;
endmodule
module datapath(output Zero,output  [4:0]A1,A2,A3,output [31:0]Wd3,Pc,WriteData,AluResult,input clk,PCSrc,AluSrc,reset,input [1:0]ResultSrc,ImmSrc,input[2:0]AluControl,input [31:0]Rd1,Rd2,Instr,ReadData);
wire [31:0] ImmExt,PCNext,PCTraget,PCPlus4,SrcA,SrcB,Result;
assign A1=Instr[19:15];
assign A2=Instr[24:20];
assign A3=Instr[11:7];
assign Wd3=Result;
assign WriteData=Rd2;
assign SrcA=Rd1;
mux m2(SrcB,Rd2,ImmExt,AluSrc);
register rr(Pc,PCNext,reset,clk);
mux m1(PCNext,PCPlus4,PCTraget,PCSrc);
adder a1(PCPlus4,Pc,32'd4);
adder a2(PCTraget,Pc,ImmExt);
signextent s(ImmExt,Instr,ImmSrc);
alu al(AluResult,Zero,SrcA,SrcB,AluControl);
mmux m3(Result,AluResult,ReadData,PCPlus4,ResultSrc);
endmodule