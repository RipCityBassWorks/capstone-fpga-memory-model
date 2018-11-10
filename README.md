# capstone-fpga-memory-model

A Proof of Concept / Critical Design Subsystem <br />
For an FPGA Based Random Number Generator <br />
Part of a Senior Capstone Project

## Function
* The LFSR is initialized with an arbitrary 16 bit binary value
* Upon user input via btn(0), bit 14 of the LFSR is set to (bit 0) xor (bit 1)
* btn(0) = '1' is the enable condition
* This simulates a single event effect
* The output from the LFSR is continuously sent to the UART at the same frequency as the LFSR (user selectable by sw(1 downto 0))
* The output is converted to hexadecimal prior to being displayed on a terminal 
* The output of the LFSR with the enable condition is stored in a slot of the 128x16 memory block
* The LEDs and RGB LEDs loop the binary values of the top 8 bits of the values stored in memory

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
STATUS: complete <br />
Converts the binary values stored <br />
in memory to signals for the LEDs


### delay_counter.vhd
STATUS: complete <br />
1.5 second counter that output <br />
A one after 1.5 seconds and <br />
Outputs a zero during counting 


### lfsr.vhd 
STATUS: complete <br />
Linear Feedback Shift Register <br />
Used for generating hardware level <br />
32 bit Pseudo random numbers 


### rw_128x32.vhd
STATUS: needs testing + debugging <br />
Memory to store and retrieve Pseudo random <br />
numbers generated from lfsr.vhd on the FPGA <br />
VHDL read/write memory model using an array of vectors


### memory.vhd 
STATUS: needs testing + debugging <br />
Control for rw_128x32.vhd <br />
Populates the r/w memory with 32 bit numbers <br />
And then reads back the values <br />


### btn_debounce.vhd 
STATUS: needs testing + debugging <br />
control component for debouncing and <br />
synchronizing the push-buttons for future use <br />


### dflipflop.vhd 
STATUS: needs testing + debugging <br />
VHDL model of a d-flip-flop <br />
Used for debouncing the push buttons


### UART IP Core
STATUS: In progress <br />
Xilinx IP Core for communication to a computer <br />
Terminal over UART. The numbers stored in memory will be <br />
Sent as inputs and displayed in the computer terminal







