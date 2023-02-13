module RISCV_processor (clk,rst);

	input clk,rst;
	wire pcsrc,regwrite,alusrc,memwrite,resultsrc,zf,sf;
	wire [2:0] alucontrol;
	wire [1:0] immsrc;
	wire [10:0] op_func;
	

	Risc_DataPath DP (
					   
					   .CLK(clk),
					   .PCSrc(pcsrc),
					   .RegWrite(regwrite),
					   .ALUSrc(alusrc),
					   .MemWrite(memwrite),
					   .ResultSrc(resultsrc),
					   .ALUControl(alucontrol),
					   .ImmSrc(immsrc),
					   .ZF(zf),
					   .SF(sf),
					   .rst(rst),
					   .op_func(op_func)
					  );

	control_unit CU (
					   .op(op_func[6:0]),
					   .funct3(op_func[9:7]),
					   .funct7_5(op_func[10]),
					   .ZF(zf),
					   .SF(sf),
					   .PCSrc(pcsrc),
					   .ResultSrc(resultsrc),
					   .MemWrite(memwrite),
					   .ALUSrc(alusrc),
					   .RegWrite(regwrite),
					   .ALUControl(alucontrol),
					   .ImmSrc(immsrc)
					 );

endmodule