module MEM (input [31:0] address, output wire [31:0] out);

reg [31:0] mem [32'h4ff:32'h400];

initial
begin
  $readmemh("mem.hex", mem);
end

assign
  out = mem[address/4];

endmodule
