module ALU(SrcA,SrcB,ALUControl,ALUResult,ZF,SF);

	input [31:0] SrcA,SrcB;
	input [2:0] ALUControl;
	output reg [31:0] ALUResult;
	output reg ZF,SF;

	always@(*)begin
		
		case(ALUControl)

			3'b000: ALUResult = SrcA + SrcB;
			3'b001: ALUResult = SrcA << SrcB[4:0];
			3'b010: ALUResult = SrcA - SrcB;
			3'b100: ALUResult = SrcA ^ SrcB;
			3'b101: ALUResult = SrcA >> SrcB[4:0];
			3'b110: ALUResult = SrcA | SrcB;
			3'b111: ALUResult = SrcA & SrcB;
			default ALUResult = 32'bx;
		endcase

		if(ALUResult == 0) ZF = 1;
		else ZF = 0;

		SF = ALUResult[31];

	end
endmodule