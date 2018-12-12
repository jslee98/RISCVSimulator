module DATA(input [31:0] addr, input mem_rw, input [1:0] mem_val, input clock, input [31:0] rs2, output reg [31:0] rdata);
  reg [31:0] mem [32'h3bfff:32'hc00];
  integer index;

  initial begin
    index = 32'hc00;
    while (index < 32'h3bfff) begin
        mem[index] = 0;
        index = index + 1;
    end
  end

  always @(addr, mem_rw) begin
    if(!mem_rw) begin
      rdata = mem[addr/4];
    end
  end

  always @(addr, rs2) begin
    if(mem_rw) begin
      mem[addr/4] = rs2;
    end
  end

endmodule
