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
        CLK100MHZ      : in    std_logic;
        --Switches
        sw              : in    std_logic_vector(3 downto 0);
        --LEDs
        led             : out   std_logic_vector(3 downto 0);
		--RGB LEDs
		led0_b			: out	std_logic;
		led0_g			: out	std_logic;
		led0_r			: out	std_logic;
		led1_b			: out	std_logic;
		led1_g			: out	std_logic;
		led1_r			: out	std_logic;
		led2_b			: out	std_logic;
		led2_g			: out	std_logic;
		led2_r			: out	std_logic;
		led3_b			: out	std_logic;
		led3_g			: out	std_logic;
		led3_r			: out	std_logic;
        --Buttons
        btn             : in    std_logic_vector(3 downto 0);
        --Pmod Header JA
        ja              : out   std_logic_vector(7 downto 0);
        --Pmod Header JB
        jb              : out   std_logic_vector(7 downto 0);
        --Pmod Header JC
        jc              : out   std_logic_vector(7 downto 0);
        --Pmod Header JD
        jd              : out   std_logic_vector(7 downto 0);
        --USB-UART Interface
        uart_rxd_out    : out   std_logic;
        uart_txd_in     : in    std_logic
    );
end xc7_top_level;

architecture xc7_top_level_arch of xc7_top_level is

signal test             : std_logic     := '0';

begin
    
    process(CLK100MHZ)
        begin
            if(rising_edge(CLK100MHZ)) then
                uart_rxd_out <= not test;
            end if;
    end process;
        

end xc7_top_level_arch;
