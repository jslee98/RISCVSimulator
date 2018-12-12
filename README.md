# RISC-V Sodor Simulator

This was a solo project for CSCI 320 - Computer Architecture at Bucknell. We simulated a 1-stage RISC-V Sodor processor in Verilog with support for 20+ instructions including ALU operations, memory load and stores, branching and jumps. The program is read from the mem.hex file, translated into binary, decoded, and executed. The CPU time, PC address, and decoded assembly instruction are printed at each positive clock edge, and the current register contents are printed at each negative clock edge.

All modules are implemented in their own file and connected in the riscv_testbench file. To run the simulator, run 'make' then execute a.out.

Below is an image representing the processor we implemented.

![alt text](https://i.imgur.com/auD2Lul.png)
