module MUX4(input wire [1:0] wb_sel, input wire [31:0] alu, input wire [31:0] csr_reg, input wire [31:0] pc_4, input wire [31:0] rdata,
            input wire [1:0] op2sel, input wire [31:0] pc, input wire [11:0] immi, input wire [19:0] imms, input wire [31:0] rs2,
            output reg [31:0] op2_out, output reg [31:0] wb_out);

always @ ( wb_sel, alu, rdata, pc_4, csr_reg ) begin
  case (wb_sel)
    2'b00: begin
      wb_out <= alu;
    end
    2'b01: begin
      wb_out <= rdata;
    end
    2'b10: begin
      wb_out <= pc_4;
    end
    2'b11: begin
      wb_out <= csr_reg;
    end
  endcase
end

always @ ( op2sel, rs2, immi, pc, imms ) begin
  case (op2sel)
    2'b00: begin
      op2_out <= rs2;
    end
    2'b01: begin
      //$display("immi= %d", immi);
      op2_out <= $signed(immi);
    end
    2'b10: begin
      op2_out <= pc;
    end
    2'b11: begin
      op2_out <= $signed(imms);
    end
  endcase
end

endmodule
