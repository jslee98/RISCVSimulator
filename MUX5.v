module MUX5(input wire [2:0] pc_sel, input [31:0] current_pc, input wire [31:0] pc_4, input wire [31:0] jalr, input wire [11:0] branch, input wire [19:0] jump, input wire [31:0] exception, output reg [31:0] out);
reg [19:0] jump_loc;
//reg [11:0] branch_loc;

always @ ( pc_sel, pc_4 ) begin
//$display("setting instruction, pc_sel = %d", pc_sel);
  case ( pc_sel )
  3'b000: begin
    out = pc_4;
  end
  3'b001: begin
    out = jalr;
  end
  3'b010: begin
    jump_loc = jump * 2;
    //$display("jumping to... pc + %d", $signed(jump_loc));
    out = $signed(current_pc) + $signed(jump_loc);
  end
  3'b011: begin
    //branch_loc = branch * 2;
    out = $signed(current_pc) + $signed(branch);
  end
  3'b100: begin
    out = exception;
  end
  endcase
end

endmodule
