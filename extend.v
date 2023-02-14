module extend (Imm,ImmSrc,Imm_Ext);

	input [1:0] ImmSrc;
	input [24:0] Imm;
	output reg [31:0] Imm_Ext;

	always@(*)begin
		case(ImmSrc)
			2'b00:Imm_Ext = {{20{Imm[24]}},Imm[24:13]}; //I type instruction
			2'b01:Imm_Ext = {{20{Imm[24]}},Imm[24:18],Imm[4:0]}; //S type instruction
			2'b10:Imm_Ext = {{20{Imm[24]}},Imm[0],Imm[23:18],Imm[4:1],1'b0}; //B type instruction
			default Imm_Ext = 32'bx;
		endcase
	end

endmodule
