module Data_mem(A,WD,WE,CLK,RD);

	input [31:0] A,WD;
	input WE,CLK;
	output [31:0] RD;

	reg [7:0] DM [0:'h255];

	always@(posedge CLK)begin
		if(WE) {DM[A+3],DM[A+2],DM[A+1],DM[A]}<=WD;
	end

	assign RD = {DM[A+3],DM[A+2],DM[A+1],DM[A]};

endmodule
