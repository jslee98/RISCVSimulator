`include "riscv.vh"

module CONTROL(input [31:0] inst, input [31:0] rs1, input [31:0] rs2, output reg [2:0] pc_sel, output reg [4:0] alufun, output reg op1sel, output reg [1:0] op2sel, output reg [1:0] wb_sel, output reg rf_wen, output reg mem_rw, output reg [1:0] mem_val);

reg [6:0] funct7;
reg [3:0] funct3;
reg [6:0] opcode;

always @ ( inst, rs1, rs2 ) begin
   funct7 = inst[`func7];
   funct3 = inst[`func3];
   opcode = inst[`op];

   case(opcode)
    `RTYPE: begin
        case(funct3)
          `R3_ADD: begin
            case(funct7)
              `R7_ADD: begin
                alufun = `ADD;
                pc_sel = 0;
                op1sel = 0;
                op2sel = 0;
                wb_sel = 0;
                rf_wen = 1;
                mem_rw = 0;
                mem_val = 0;
              end
              `R7_SUB: begin
                alufun = `SUB;
                pc_sel = 0;
                op1sel = 0;
                op2sel = 0;
                wb_sel = 0;
                rf_wen = 1;
                mem_rw = 0;
                mem_val = 0;
              end
            endcase
          end
          `R3_SLL: begin
            alufun = `SLL;
            pc_sel = 0;
            op1sel = 0;
            op2sel = 0;
            wb_sel = 0;
            rf_wen = 1;
            mem_rw = 0;
            mem_val = 0;
          end
          `R3_OR: begin
            alufun = `OR;
            pc_sel = 0;
            op1sel = 0;
            op2sel = 0;
            wb_sel = 0;
            rf_wen = 1;
            mem_rw = 0;
            mem_val = 0;
          end
          `R3_XOR: begin
            alufun = `XOR;
            pc_sel = 0;
            op1sel = 0;
            op2sel = 0;
            wb_sel = 0;
            rf_wen = 1;
            mem_rw = 0;
            mem_val = 0;
          end
        endcase
    end
    `ITYPE: begin
      case(funct3)
        `I3_ADDI: begin
          alufun = `ADDI;
          pc_sel = 0;
          op1sel = 0;
          op2sel = 1;
          wb_sel = 0;
          rf_wen = 1;
          mem_rw = 0;
          mem_val = 0;
        end
        `I3_SLLI: begin
          alufun = `SLLI;
          pc_sel = 0;
          op1sel = 0;
          op2sel = 1;
          wb_sel = 0;
          rf_wen = 1;
          mem_rw = 0;
          mem_val = 0;
        end
        `I3_SLTI: begin
          alufun = `SLTI;
          pc_sel = 0;
          op1sel = 0;
          op2sel = 1;
          wb_sel = 0;
          rf_wen = 1;
          mem_rw = 0;
          mem_val = 0;
        end
        `I3_ORI: begin
          alufun = `ORI;
          pc_sel = 0;
          op1sel = 0;
          op2sel = 1;
          wb_sel = 0;
          rf_wen = 1;
          mem_rw = 0;
          mem_val = 0;
        end
        `I3_ANDI: begin
          alufun = `ANDI;
          pc_sel = 0;
          op1sel = 0;
          op2sel = 1;
          wb_sel = 0;
          rf_wen = 1;
          mem_rw = 0;
          mem_val = 0;
        end
      endcase
    end
    `BTYPE: begin
      case(funct3)
        `B3_BEQ: begin
          if(rs1 == rs2) begin
            //$display("beq taken rs1 = %d, rs2 = %d", rs1, rs2);
            pc_sel = 2'b11;
            op1sel = 0;
            op2sel = 0;
            wb_sel = 0;
            rf_wen = 0;
            mem_rw = 0;
            mem_val = 0;
          end
        end
        `B3_BNE: begin
          if(rs1 != rs2) begin
            //$display("bne taken rs1 = %d, rs2 = %d", rs1, rs2);
            pc_sel = 2'b11;
            op1sel = 0;
            op2sel = 0;
            wb_sel = 0;
            rf_wen = 0;
            mem_rw = 0;
          end
        end
      endcase
    end
    `UTYPE: begin
      alufun = `LUI;
      pc_sel = 0;
      op1sel = 1;
      op2sel = 2'b11;
      wb_sel = 0;
      rf_wen = 1;
      mem_rw = 0;
    end
    `LTYPE: begin
      alufun = `LOAD;
      pc_sel = 0;
      op1sel = 0;
      op2sel = 2'b11;
      wb_sel = 1;
      rf_wen = 1;
      mem_rw = 0;
      mem_val = 0;
    end
    `STYPE: begin
      alufun = `STORE;
      pc_sel = 0;
      op1sel = 0;
      op2sel = 0;
      wb_sel = 0;
      rf_wen = 0;
      mem_rw = 1;
      mem_val = 0;
    end
    `JTYPE: begin
      pc_sel = 3'b010;
      wb_sel = 2'b10;
      rf_wen = 1;
      mem_rw = 0;
    end
  endcase
end

endmodule
