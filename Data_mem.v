module Data_mem(A,WD,WE,CLK,RD);

	input [31:0] A,WD;
	input WE,CLK;
	output [31:0] RD;

	reg [31:0] DM [0:63];

	always@(posedge CLK)begin
		if(WE) DM[A[31:2]]<=WD;
	end

	assign RD = DM[A[31:2]];

endmodule
