module pc_inc(pc,inc,pc_new);

	input [31:0] pc,inc;
	output pc_new;

	assign inc = 4;
	assign pc_new = pc + inc;

endmodule
