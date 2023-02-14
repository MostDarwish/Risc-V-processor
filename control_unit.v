module control_unit (op,funct3,funct7_5,ZF,SF,PCSrc,ResultSrc,MemWrite,ALUSrc,RegWrite,ALUControl,ImmSrc,HALT);

	input [6:0] op;
	input [2:0] funct3;
	input funct7_5,ZF,SF; 
	output reg PCSrc,ResultSrc,MemWrite,ALUSrc,RegWrite,HALT;
	output reg [2:0] ALUControl;
	output reg [1:0] ImmSrc;
	reg Branch;
	reg [1:0] ALUOp;

	always@(*)begin
		
		case(op)
		7'b000_0011:begin //LOAD
						RegWrite = 1;
						ImmSrc = 00;
						ALUSrc = 1;
						MemWrite = 0;
						ResultSrc = 1;
						Branch = 0;
						ALUOp = 00;
						HALT = 0;
					end
		7'b010_0011:begin //STORE
						RegWrite = 0;
						ImmSrc = 01;
						ALUSrc = 1;
						MemWrite = 1;
						ResultSrc = 1'bx;
						Branch = 0;
						ALUOp = 00;
						HALT = 0;
					end
		7'b011_0011:begin //R-TYPE
						RegWrite = 1;
						ImmSrc = 2'bxx;
						ALUSrc = 0;
						MemWrite = 0;
						ResultSrc = 0;
						Branch = 0;
						ALUOp = 2'b10;
						HALT = 0;
					end
		7'b001_0011:begin //I-TYPE
						RegWrite = 1;
						ImmSrc = 0;
						ALUSrc = 1;
						MemWrite = 0;
						ResultSrc = 0;
						Branch = 0;
						ALUOp = 2'b10;
						HALT = 0;
					end			
		7'b110_0011:begin //B-TYPE
						RegWrite = 0;
						ImmSrc = 2'b10;
						ALUSrc = 0;
						MemWrite = 0;
						ResultSrc = 1'bx;
						Branch = 1;
						ALUOp = 2'b01;
						HALT = 0;
					end
		default:begin //if any error hapend or a wrong OP code be installed in the instruction memory
						RegWrite = 0;
						ImmSrc = 0;
						ALUSrc = 0;
						MemWrite = 0;
						ResultSrc = 0;
						Branch = 0;
						ALUOp = 0;
						HALT = 1;
				end
		endcase

	end

	always@(*)begin
		case({Branch,funct3})
		4'b1000:PCSrc = ZF;
		4'b1001:PCSrc = ~ZF;
		4'b1100:PCSrc = SF;
		default:PCSrc = 0;
		endcase
	end

	always@(*)begin
		
		casex({ALUOp,funct3,funct7_5})
		6'b00_xxx_x:ALUControl = 0;
		6'b01_xxx_x:ALUControl = 3'b010;
		6'b10_000_0:ALUControl = 0;
		6'b10_000_1:ALUControl = 3'b010;
		6'b10_001_0:ALUControl = 3'b001;
		6'b10_100_0:ALUControl = 3'b100;
		6'b10_101_0:ALUControl = 3'b101;
		6'b10_110_0:ALUControl = 3'b110;
		6'b10_111_0:ALUControl = 3'b111;
		default: ALUControl = 0;
		endcase
	end
endmodule