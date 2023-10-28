module RF(A1,A2,A3,WD3,WE3,CLK,RD1,RD2);

  input [4:0] A1,A2,A3;
  input [31:0] WD3;
  input WE3,CLK;
  output [31:0] RD1,RD2;

  reg [31:0] reg_file [0:31];

  always@(posedge CLK)
  begin
    if(WE3)
      reg_file[A3] <= WD3;
  end
  assign RD1 = reg_file[A1];
  assign RD2 = reg_file[A2];

  initial
  begin
    $readmemh("reg_file.txt",reg_file);
  end

endmodule
