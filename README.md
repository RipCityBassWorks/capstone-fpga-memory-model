# capstone-fpga-memory-model

A Proof of Concept / Critical Design Subsystem 
For an FPGA Based Random Number Generator
Part of a Senior Capstone Project

## Board Information
* Arty A7-35T
* FPGA: XC7A35TICSG324-1L
* From Digilent Corp.
* Xilinx Vivado WebPACK IDE

## Road-map

### Arty-A7-35-Master.xdc
STATUS: complete
Master XDC constants file
Provided by Digilent Corp.

### xc7_top_level.vhd
STATUS: in progress
Top level VHDL file 
Pin I/O and component declarations

### clock_divider.vhd
STATUS: not started


### led_decoder.vhd
STATUS: not started
Converts the binary values stored
in memory to signals for the RGB LEDs

### Memory Model
STATUS: not started
Memory to store and retrieve Pseudo random
numbers on the FPGA using a linear shift register
* Option 1: VHDL read/write memory model using an array of vectors
* Option 2: Xilinx Memory IP Core





