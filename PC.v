module PC(PCNext,PC,CLK,rst);

input CLK,rst;
input[31:0] PCNext;
output reg [31:0] PC;

always@(posedge CLK or posedge rst)begin

	if(rst) PC<=0;
	else
	PC <= PCNext;

end

endmodule
