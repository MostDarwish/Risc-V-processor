module Risc_DataPath(CLK,PCSrc,RegWrite,ALUSrc,MemWrite,ResultSrc,ALUControl,ImmSrc,ZF,SF,rst,op_func,HALT);

  input CLK,PCSrc,RegWrite,ALUSrc,MemWrite,ResultSrc,rst,HALT;
  input [2:0] ALUControl;
  input [1:0] ImmSrc;
  output ZF,SF;
  output [10:0] op_func;
  wire [31:0] PC,PCPlus4,PCNext,Instr,SrcA,SrcB,RD2,ALUResult,ImmExt,PCTarget,ReadData,Result;

  PC              pc        (.PCNext(PCNext),.rst(rst),.CLK(CLK),.PC(PC),.HALT(HALT));
  pc_inc          PCInc     (.pc(PC),.pcPlus4(PCPlus4));
  inst_mem        InsMem    (.A(PC),.RD(Instr));
  RF              RF        (.A1(Instr[19:15]),.A2(Instr[24:20]),.A3(Instr[11:7]),.WD3(Result),.WE3(RegWrite),.CLK(CLK),.RD1(SrcA),.RD2(RD2));
  extend          extend    (.Imm(Instr[31:7]),.ImmSrc(ImmSrc),.Imm_Ext(ImmExt));
  ALU             ALU       (.SrcA(SrcA),.SrcB(SrcB),.ALUControl(ALUControl),.ALUResult(ALUResult),.ZF(ZF),.SF(SF));
  _32_bit_adder   Adder     (.in1(PC),.in2(ImmExt),.out(PCTarget));
  Data_mem        Dmem      (.A(ALUResult),.WD(RD2),.WE(MemWrite),.CLK(CLK),.RD(ReadData));


  MUX2x1          PC_MUX    (.A(PCPlus4),.B(PCTarget),.sel(PCSrc),.out(PCNext));
  MUX2x1          ALU_MUX   (.A(RD2),.B(ImmExt),.sel(ALUSrc),.out(SrcB));
  MUX2x1          DMem_MUX  (.A(ALUResult),.B(ReadData),.sel(ResultSrc),.out(Result));

  assign op_func = {Instr[30],Instr[14:12],Instr[6:0]};


endmodule
