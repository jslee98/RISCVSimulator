# RISCVSimulator

This was a solo project for CSCI 320 - Computer Architecture at Bucknell. We simulated a 1-stage RISC-V Sodor processor in Verilog with support for 20+ instructions including ALU operations, memory load and stores, branching and jumps. The program is read from the mem.hex file, translated into binary, decoded, and executed. Register contents are printed to the console at each clock cycle, as well as the decoded assembly instruction at each negative clock edge.

![alt text](https://i.imgur.com/auD2Lul.png)