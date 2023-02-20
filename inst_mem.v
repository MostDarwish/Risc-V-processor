module inst_mem(A,RD);

	input [31:0] A;
	output [31:0] RD;


	reg [31:0] inst_mem [0:63];

	assign RD = inst_mem[A[31:2]];

	initial begin
		$readmemh("assembly_code.txt",inst_mem);
	end

endmodule
