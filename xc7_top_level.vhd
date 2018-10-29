----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/18/2018 04:38:16 PM
-- Design Name: 
-- Module Name: xc7_top_level - xc7_top_level_arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
end xc7_top_level;

architecture xc7_top_level_arch of xc7_top_level is
    
--COMPONENT DECLARATIONS
    component clock_divider is
    port(
        clk_in          : in    std_logic;
        reset           : in    std_logic;
        sel             : in    std_logic_vector(1 downto 0);
        clk_out         : out   std_logic
    );
    end component clock_divider;
    
    component led_decoder is
        port(
            clk             : in    std_logic;
            reset           : in    std_logic;
            mem_block       : in    std_logic_vector(15 downto 0);
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
    
--SIGNALS    
    signal clock            : std_logic;
    signal mem_block        : std_logic_vector(15 downto 0);            

begin
    
    DIVIDE_CLOCK    :   clock_divider   port map(CLK100MHZ, btn(3), sw(1 downto 0), clock);
    
    LED_DECODE      :   led_decoder
        port map(
            CLK100MHZ,
            btn(3),
            mem_block,
            led,               
            led0_b,
            led0_g,
            led0_r,
            led1_b,
            led1_g,
            led1_r,
            led2_b,
            led2_g,
            led2_r,
            led3_b,
            led3_g,      
            led3_r
        );
    
    
    
    
end xc7_top_level_arch;
