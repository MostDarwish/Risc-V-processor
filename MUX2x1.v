module MUX2x1(A,B,sel,out);

	input [31:0] A,B;
	input sel;
	output [31:0] out;

	assign out = out?B:A;

endmodule
