`include "riscv.vh"
module DECODER(input wire [31:0] data, output reg [180:0] str);

reg[`op] opcode;

reg[5:0] rd;
reg[5:0] rs1;
reg[5:0] rs2;
reg[2:0] func3;
reg[6:0] func7;
reg[11:0] imm;
reg[19:0] imm20;

always @(*) begin
    opcode <= data[`op];
    case(opcode)
      `RTYPE: begin
        rd = data[`rd];
        rs1 = data[`rs1];
        rs2 = data[`rs2];
        func3 = data[`func3];
        func7 = data[`func7];
        case(func3)
          `R3_ADD: begin
            case(func7)
              `R7_ADD: begin
                $sformat(str,"add %s, %s, %s",  rname(rd), rname(rs1), rname(rs2));
              end
              `R7_SUB: begin
                $sformat(str,"sub %s, %s, %s",  rname(rd), rname(rs1), rname(rs2));
              end
            endcase
          end
          `R3_SLL: begin
            $sformat(str,"sll %s, %s, %s",  rname(rd), rname(rs1), rname(rs2));
          end
          `R3_OR: begin
            $sformat(str,"or %s, %s, %s",  rname(rd), rname(rs1), rname(rs2));
          end
          `R3_XOR: begin
            $sformat(str,"xor %s, %s, %s",  rname(rd), rname(rs1), rname(rs2));
          end
          default:
            $sformat(str,"not supported");
        endcase
      end
      `ITYPE: begin
        rd = data[`rd];
        rs1 = data[`rs1];
        imm = data[`imm12];
        func3 = data[`func3];
        case(func3)
          `I3_ADDI: begin
            $sformat(str,"addi %s, %s, %d",  rname(rd), rname(rs1), $signed(imm));
          end
          `I3_SLLI: begin
            $sformat(str,"slli %s, %s, %d",  rname(rd), rname(rs1), $signed(imm));
          end
          `I3_SLTI: begin
            $sformat(str,"slti %s, %s, %d",  rname(rd), rname(rs1), $signed(imm));
          end
          `I3_ORI: begin
            $sformat(str,"ori %s, %s, %d",  rname(rd), rname(rs1), $signed(imm));
          end
          `I3_ANDI: begin
            $sformat(str,"andi %s, %s, %d",  rname(rd), rname(rs1), $signed(imm));
          end
        endcase

      end
      `ECALL: begin
        str = "ecall";
      end
      `NOP: begin
        str = "nop";
      end
      `UTYPE: begin
        $sformat(str,"lui %s, %d",  rname(rd), data[`ui20]);
      end
      `BTYPE: begin
        rs1 = data[`rs1];
        rs2 = data[`rs2];
        imm[11:5] = data[31:25];
        imm[4:0] = data[11:7];
        func3 = data[`func3];
        case(func3)
          `B3_BNE: begin
            $sformat(str,"bne %s, %s, %d",  rname(rs1), rname(rs2), $signed(imm));
          end
          `B3_BEQ: begin
            $sformat(str,"beq %s, %s, %d",  rname(rs1), rname(rs2), $signed(imm));
          end
        endcase
      end
      `LTYPE: begin
        rs1 = data[`rs1];
        rd = data[`rd];
        imm = data[`imm12];
        $sformat(str,"lw %s, %d(%s)",  rname(rd), imm, rname(rs1));
      end
      `STYPE: begin
        rs1 = data[`rs1];
        rs2 = data[`rs2];
        imm[11:5] = data[31:25];
        imm[4:0] = data[11:7];
        $sformat(str,"sw %s, %d(%s)",  rname(rs2), imm, rname(rs1));
      end
      `JTYPE: begin
        rd = data[`rd];
        imm20 = {data[31], data[19:12], data[20], data[30:21]};
        imm20 = imm20 * 2;
        $sformat(str,"jal %s, %d", rname(rd), $signed(imm20));
      end
      default: begin
        $sformat(str,"unknown: op = %b", opcode);
      end
    endcase
end

function [31:0] rname(input[`REGADDR] r);
reg [31:0] name;
begin
  case(r)
    0: name = "zero";
    1: name = "ra";
    2: name = "sp";
    3: name = "gp";
    4: name = "tp";
    5,6,7: $sformat(name, "t%1d", r-5);
    8,9: $sformat(name, "s%1d", r-8);
    10,11,12,13,14,15,16,17: $sformat(name, "a%1d", r-10);
    18,19,20,21,22,23,24,25,26,27: $sformat(name, "s%1d", r-16);
    28,29,30,31: $sformat(name, "t%1d", r-25);
    default: name = "xxxx";
  endcase
  $sformat(name, "%4s", name);
  rname = name;
end
endfunction

endmodule
