`ifndef _riscv_vh_
`define _riscv_vh_

/*
 RISCV CPU definitions for lab01
 */

`define WIDTH 32  // bit width of processor
`define CYCLE 10  // simulation time ticks per clock
`define REGADDR 4:0
`define INIT_PC 32'h1000 // initial PC value

/*-----------------------------------------------------------------------*
 * Instruction Fields                                                    *
 *-----------------------------------------------------------------------*/
`define op           6:0    // 7 bit opcode
`define rd           11:7   // 5-bit destination register specifier
`define rs1          19:15  // 5-bit source register specifier
`define rs2          24:20  // 5-bit source/dest register spec or sub opcode
`define func3        14:12  // 3-bit func3 field
`define func7        31:25  // 7-bit func7 field
`define imm12        31:20  // 12-bit immediate for I type instructions
`define ui20         31:12  // 20 bit upper immediate for U type

 /*-----------------------------------------------------------------------*
  * Opcode Assignments for `op Operations                                 *
  *-----------------------------------------------------------------------*/

`define RTYPE  7'h33 // all R-type instructions
`define ITYPE  7'h13
`define UTYPE  7'h37
`define BTYPE  7'h63
`define STYPE  7'h23
`define LTYPE  7'h03
`define JTYPE  7'h6f
`define ECALL  7'h73 // equal to SYSCALL
`define NOP    7'h0

/*-----------------------------------------------------------------------*
 * func3 Assignments for `func3 Operations for RTYPE                     *
 *-----------------------------------------------------------------------*/
`define R3_ADD   3'b000
`define R3_SLL   3'b001
`define R3_SLT   3'b010
`define R3_SLTU  3'b011
`define R3_XOR   3'b100
`define R3_SRL   3'b101
`define R3_OR    3'b110
`define R3_AND   3'b111

`define R7_ADD   7'h0
`define R7_SUB   7'h01
`define R7_MUL   7'h20

/*-----------------------------------------------------------------------*
 * func3 Assignments for `func3 Operations for ITYPE                     *
 *-----------------------------------------------------------------------*/
`define I3_ADDI  3'b000
`define I3_SLLI  3'b001
`define I3_SLTI  3'b010
`define I3_ORI   3'b110
`define I3_ANDI  3'b111

/*-----------------------------------------------------------------------*
 * func3 Assignments for `func3 other types                              *
 *-----------------------------------------------------------------------*/
`define B3_BEQ  3'b000
`define B3_BNE  3'b001
`define L3_LW   3'b002
`define S3_SW   3'b002


/*-----------------------------------------------------------------------*
 * alufun variables                                                      *
 *-----------------------------------------------------------------------*/

`define ADD   5'b0
`define SUB   5'b10
`define SLL   5'b11
`define OR    5'b1010
`define XOR   5'b110
`define ADDI  5'b10000
`define SLLI  5'b10001
`define SLTI  5'b10010
`define ORI   5'b10110
`define ANDI  5'b10111
`define LUI   5'b11110
`define LOAD  5'b1111
`define STORE 5'b11011

`endif
