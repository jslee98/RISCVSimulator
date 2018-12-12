module ADD4(input wire [31:0] current_address, output reg [31:0] next_address);

always @(*)
  next_address <= current_address + 4;

endmodule
