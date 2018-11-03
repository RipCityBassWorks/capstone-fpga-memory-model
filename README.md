# capstone-fpga-memory-model

A Proof of Concept / Critical Design Subsystem <br />
For an FPGA Based Random Number Generator <br />
Part of a Senior Capstone Project

## Board Information
* Arty A7-35T
* FPGA: XC7A35TICSG324-1L
* From Digilent Corp.
* Xilinx Vivado WebPACK IDE

## Road-map

### Arty-A7-35-Master.xdc
STATUS: complete <br />
Master XDC constants file <br />
Provided by Digilent Corp. 

### xc7_top_level.vhd
STATUS: in progress <br />
Top level VHDL file <br />
Pin I/O and component declarations

### clock_divider.vhd
STATUS: needs testing + debugging <br />
Scales down the clock so that the LED output <br />
Is visible whenever a new number is generated


### led_decoder.vhd
STATUS: needs testing + debugging <br />
Converts the binary values stored <br />
in memory to signals for the RGB LEDs


### delay_counter.vhd
STATUS: needs testing + debugging <br />
Four second counter that output <br />
A one after four seconds and <br />
Outputs a zero during counting 


### lfsr.vhd 
STATUS: needs testing + debugging <br />
Linear Feedback Shift Register <br />
Used for generate hardware level <br />
Pseudo random numbers 


### Memory Model
STATUS: in progress <br />
Memory to store and retrieve Pseudo random <br />
numbers on the FPGA using a linear shift register <br />
VHDL read/write memory model using an array of vectors








