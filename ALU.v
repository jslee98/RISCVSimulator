`include "riscv.vh"

module ALU(input wire [31:0] in1, input wire [31:0] in2, input wire [4:0] alufun, output reg [31:0] res);

always @ ( in1, in2 ) begin
  case ( alufun )
    `ADD, `ADDI: begin // add, addi
      res = in1 + $signed(in2);
      //$display("add executed in alu, in1 = %d, in2 = %d", in1, in2);
    end
    `SLL, `SLLI: begin // shift left
      res = shift_left(in1, in2);
    end
    `LUI: begin
      res[31:12] = in2;
      res[11:0] = 0;
    end
    `ORI, `OR: begin
      res = or_func(in1, in2);
    end
    `ANDI: begin
      res = and_func(in1, in2);
    end
    `SLTI: begin
      if ($signed(in1) < $signed(in2))
        res = 1;
      else
        res = 0;
    end
    `SUB: begin
      res = in1 - in2;
    end
    `XOR: begin
      res = xor_func(in1, in2);
    end
    `LOAD, `STORE: begin
      //$display("%m in1 = %h, in2 = %h", in1, in2);
      res = in1;
    end
  endcase
end

function [31:0] shift_left(input[31:0] base, input[31:0] power);
reg [31:0] result;
begin
  result = base;
  while (power > 0) begin
    result = result * 2;
    power = power - 1;
  end
  shift_left = result;
end
endfunction

function [31:0] or_func(input[31:0] num_one, input[31:0] num_two);
reg [31:0] result;
integer or_index;
begin
  or_index = 0;
  while (or_index < 32) begin
    result[or_index] = num_one[or_index] || num_two[or_index];
    or_index++;
  end
  or_func = result;
end
endfunction

function [31:0] xor_func(input[31:0] num_one, input[31:0] num_two);
reg [31:0] result;
integer xor_index;
begin
  xor_index = 0;
  while (xor_index < 32) begin
    result[xor_index] = num_one[xor_index] ^ num_two[xor_index];
    xor_index++;
  end
  xor_func = result;
end
endfunction

function [31:0] and_func(input[31:0] num_one, input[31:0] num_two);
reg [31:0] result;
integer and_index;
begin
  and_index = 0;
  while (and_index < 32) begin
    result[and_index] = num_one[and_index] && num_two[and_index];
    and_index++;
  end
  and_func = result;
end
endfunction

endmodule
