module inst_mem(A,RD);

	input [31:0] A;
	output [31:0] RD;


	reg [7:0] inst_mem [0:255];

	assign RD = {inst_mem[A+3],inst_mem[A+2],inst_mem[A+1],inst_mem[A]};

	initial begin
		$readmemh("assembly_code.txt",inst_mem);
	end

endmodule
