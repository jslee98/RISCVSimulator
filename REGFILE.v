`include "riscv.vh"

module REGFILE(input [2:0] pc_sel, input [31:0] instruction, input wire [`REGADDR] ir1, input wire [`REGADDR] ir2, input wire [`REGADDR] ir3, input wire [31:0] write_data, input wire rf_wen, input clock, output reg [31:0] rs1, output reg [31:0] rs2);

reg [31:0] registers [31:0];
integer index;
reg [31:0] reg_name;

initial begin
  index = 0;
  while (index < 32) begin
      registers[index] = 0;
      index = index + 1;
  end
  registers[2] = 32'heffff;
end

always @ ( negedge clock ) begin
  if(rf_wen && ir3 != 0) begin
    registers[ir3] = $signed(write_data);
  end
  else if (rf_wen && pc_sel == 3'b10) begin
    registers[1] = write_data;
  end
end

always @ ( ir1, ir2, registers[ir1], registers[ir2], instruction ) begin
  $display("registers being set, ir1 = %d, ir2 = %d", ir1, ir2);
  rs1 <= registers[ir1];
  rs2 <= registers[ir2];
end

task printAll;
integer print_index;
begin
print_index = 0;
while (print_index < 32)
    begin
      $display("%s: %h   %s: %h  %s: %h   %s: %h", rname(print_index), registers[print_index], rname(print_index + 1), registers[print_index + 1], rname(print_index + 2), registers[print_index + 2], rname(print_index + 3), registers[print_index + 3]);
      print_index = print_index + 4;
    end
end
endtask

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
