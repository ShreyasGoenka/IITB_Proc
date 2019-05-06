# IITB_Proc
This is the VHDL inplementation of a 16 bit processor.

The processor has a 16 bit 8 register register file along with an asynchronous read/synchronous write memory, an ALU, some temporary registers along with whatever else was required to implement the following instructions - ADD, ADZ, ADC, ADI, NDU, NDC, NDZ, LHI, LW, SW, LA, SA, BEQ, JAL and JLR.

The details about these instructions along with any other information one needs to understand the problem statement is specified in Project-1-Multicycle-RISC-IITB.pdf.

ALU.vhd - this provides functionality for additional (required for ADD, ADZ, ADC and ADI), substraction (for BEQ), NAND for NDU, NDC and NDZ along with other functionality as is required by the processors such as updating the c flag and z flag, NOR operation for BEQ etc.

CTR.vhd - LA and SA require a three bit counter to help iteratively load/store.

DUT.vhd - the control signals for almost all the components are managed inside them (allowing you to treat them as a black box), DUT is the file where we interconnect all the components to create the data path.

LS.vhd - This is a simple left shifter which shifts by seven bits.

memory_asyncread_syncwrite.vhd - This file contains the implementation for the memory used by the process.

ir.vhd - This is the Instruction Register. This store the instruction currently being executed, it loads it from memory using address in pc.

pc.vhd - this is the instruction pointer which points towards the memory location where the instruction to be executed is located.

se.vhd - this contains two sign extenders, one from 6 to 16 bits and another from 9 to 16 bits.

state.vhd - this contains the state transtion logic, which (for the most part, had to make changes for practical reasons) corresponds to state transition specified in design_document.pdf

tempRegister.vhd - this contains implementations for temp registers T1, T2 and T3 which are constantly used and required by the processer to execute the instructions.

