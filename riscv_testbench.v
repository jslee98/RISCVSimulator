`include "riscv.vh"
module riscv_testbench;

reg clock;

// wires
wire[31:0] next_pc;
wire[31:0] current_pc;
wire[31:0] instruction;
wire[180:0] decoded_instruction;
wire [31:0] muxout;
wire [31:0] aluout;
wire [31:0] wb_out;
wire [31:0] op2_out;
wire [31:0] mux5out;
wire[31:0] rs1;
wire[31:0] rs2;
wire [4:0] alufun;
wire [2:0] pc_sel;
wire [1:0] op2sel;
wire [1:0] wb_sel;
wire op1sel;
wire rf_wen;
wire mem_rw;
wire [1:0] mem_val;
wire [31:0] rdata;
wire [31:0] pc_selected;

// registers, unused
//reg [19:0] upperimm;
//reg [31:0] jalr;
//reg [31:0] branch;
//reg [31:0] jump;
reg [31:0] exception;
reg [31:0] csr_reg;



ADD4 add4(current_pc, next_pc);
MUX5 mux5(pc_sel, current_pc, next_pc, regfile.registers[1], {instruction[31:25], instruction[11:7]}, {instruction[31], instruction[19:12], instruction[20], instruction[30:21]}, exception, pc_selected);
PC pc(clock, pc_selected, current_pc);
MEM mem(current_pc, instruction);
DECODER decoder(instruction, decoded_instruction);
ALU alu(muxout, op2_out, alufun, aluout);
CONTROL control(instruction, rs1, rs2, pc_sel, alufun, op1sel, op2sel, wb_sel, rf_wen, mem_rw, mem_val);
MUX mux(op1sel, rs1, instruction[31:12], muxout);
MUX4 mux4(wb_sel, aluout, csr_reg, next_pc, rdata, op2sel, current_pc, instruction[31:20], instruction[31:12], rs2, op2_out, wb_out);
REGFILE regfile(pc_sel, instruction, instruction[19:15], instruction[24:20], instruction[11:7], wb_out, rf_wen, clock, rs1, rs2);
DATA data(aluout, mem_rw, mem_val, clock, rs2, rdata);

initial begin
  $display($time, ": Reading program from mem.hex");
  $display($time, ": boot.\n");
  clock = 0;
  #10; $monitor($time, ": PC = %h, IR = %h, %s", current_pc, instruction, decoded_instruction);
end

always @ ( negedge clock ) begin
    $display("\n------------------------------------------------------------------------------\n");
    if(instruction == `ECALL) begin
      ecall();
    end
    if (current_pc == 0 || instruction == 32'hx)
      $finish;
end

always @ ( posedge clock ) begin
  regfile.printAll();
  $display("\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
end

always begin
  #10; clock = ~clock;
end

task ecall;
begin
  if (regfile.registers[10] == 10)
    $finish;
  if (regfile.registers[10] == 1)
    $display("%d", $signed(regfile.registers[11]));
end
endtask

endmodule
