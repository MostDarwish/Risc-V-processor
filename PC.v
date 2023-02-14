module PC(PCNext,PC,CLK,rst,HALT);

input CLK,rst,HALT;
input[31:0] PCNext;
output reg [31:0] PC;

always@(posedge CLK or posedge rst)begin

	if(rst) PC<=0;
	else if(~HALT)
	    PC <= PCNext;

end

endmodule
