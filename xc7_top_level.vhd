----------------------------------------------------------------------------------
-- Stefan Andersson
-- 
-- Create Date: 10/18/2018 04:38:16 PM
-- Design Name: xc7_top_level.vhd
-- Module Name: xc7_top_level - xc7_top_level_arch
-- Project Name: capstone-fpga-memory-model 
-- Target Devices: XC7A35TICSG324-1L
-- Tool Versions: Vivado 2018.2
-- Description: Top level file
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity xc7_top_level is
    Port(--Clock signal
        CLK100MHZ           : in    std_logic;
        --Switches
        sw                  : in    std_logic_vector(3 downto 0);
        --LEDs
        led                 : out   std_logic_vector(3 downto 0);
        --RGB LEDs
        led0_b		        : out	std_logic;
        led0_g			    : out	std_logic;
        led0_r			    : out	std_logic;
        led1_b			    : out	std_logic;
        led1_g			    : out	std_logic;
        led1_r			    : out	std_logic;
        led2_b			    : out	std_logic;
        led2_g			    : out	std_logic;
        led2_r			    : out	std_logic;
        led3_b			    : out	std_logic;
        led3_g			    : out	std_logic;
        led3_r			    : out	std_logic;
        --Buttons
        btn                 : in    std_logic_vector(3 downto 0);
        --Pmod Header JA
        ja                  : out   std_logic_vector(7 downto 0);
        --Pmod Header JB
        jb                  : out   std_logic_vector(7 downto 0);
        --Pmod Header JC
        jc                  : out   std_logic_vector(7 downto 0);
        --Pmod Header JD
        jd                  : out   std_logic_vector(7 downto 0);
        --USB-UART Interface
        uart_rxd_out        : out   std_logic;
        uart_txd_in         : in    std_logic
    );
end entity xc7_top_level;

architecture xc7_top_level_arch of xc7_top_level is
    
--COMPONENT DECLARATIONS
    component clock_divider is
    port(
        clk_in              : in    std_logic;
        reset               : in    std_logic;
        sel                 : in    std_logic_vector(1 downto 0);
        clk_out             : out   std_logic
    );
    end component clock_divider;
    
    component led_decoder is
        port(
            clk             : in    std_logic;
            reset           : in    std_logic;
            mem_block       : in    std_logic_vector(7 downto 0);
            led             : out   std_logic_vector(3 downto 0);               
            led0_b          : out   std_logic;
            led0_g          : out   std_logic;
            led0_r          : out   std_logic;
            led1_b          : out   std_logic;
            led1_g          : out   std_logic;
            led1_r          : out   std_logic;
            led2_b          : out   std_logic;
            led2_g          : out   std_logic;
            led2_r          : out   std_logic;
            led3_b          : out   std_logic;
            led3_g          : out   std_logic;
            led3_r          : out   std_logic
        );
    end component led_decoder;
    
    component lfsr is
        port(
            clock           : in    std_logic;
            reset           : in    std_logic;
            reg_in          : in    std_logic_vector(31 downto 0);
            lfsr_out        : out   std_logic_vector(31 downto 0)
        );
    end component lfsr;
    
    component rw_128x32 is
        port(
            clock       : in    std_logic;
            reset       : in    std_logic;
            write       : in    std_logic;
            address     : in    std_logic_vector(31 downto 0);
            data_in     : in    std_logic_vector(31 downto 0);
            data_out    : out   std_logic_vector(31 downto 0)    
        );
    end component rw_128x32;
    
    
--SIGNALS    
    signal clock            : std_logic;
    signal led_test         : std_logic;
    signal led_test1        : std_logic;
    signal mem_block        : std_logic_vector(31 downto 0);
    signal reg_in           : std_logic_vector(31 downto 0)    := "00000101111101011110000100000000";
    signal sys_clks_sec     : std_logic_vector(31 downto 0)    := "00000101111101011110000100000000";            

begin    
    DIVIDE_CLOCK    :   clock_divider   
        port map(
            clk_in      => CLK100MHZ, 
            reset       => sw(3), 
            sel         => sw(1 downto 0), 
            clk_out     => clock
        );
    
    LED_DECODE      :   led_decoder
        port map(
            clk         => CLK100MHZ,
            reset       => sw(3),
            mem_block   => mem_block(7 downto 0),
            led         => led,               
            led0_b      => led0_b,
            led0_g      => led0_g,
            led0_r      => led0_r,
            led1_b      => led1_b,
            led1_g      => led1_g,
            led1_r      => led1_r,
            led2_b      => led2_b,
            led2_g      => led2_g,
            led2_r      => led2_r,
            led3_b      => led3_b,
            led3_g      => led3_g,      
            led3_r      => led3_r
        );
        
    SHIFT_REG       :   lfsr
        port map(
            clock       => CLK100MHZ,
            reset       => sw(3),      
            reg_in      => reg_in,    
            lfsr_out    => mem_block  
        );
    
    
end xc7_top_level_arch;
