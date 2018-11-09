----------------------------------------------------------------------------------
-- Stefan Andersson
-- 
-- Create Date: 11/03/2018 01:44:35 PM
-- Design Name: lfsr.vhd
-- Module Name: lfsr - lfsr_arch
-- Project Name: capstone-fpga-memory-model
-- Target Devices: XC7A35TICSG324-1L
-- Tool Versions: Vivado 2018.2
-- Description: Linear Feedback Shift Register 
-- for pseudo random number generation
-- Component of xc7_top_level.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity lfsr is
    port(
        clock       : in    std_logic;
        reset       : in    std_logic;
        enable      : in    std_logic;
        reg_in      : in    std_logic_vector(15 downto 0);
        lfsr_out    : out   std_logic_vector(15 downto 0)
    );
end entity lfsr;

architecture lfsr_arch of lfsr is

    
--SIGNALS    
    signal shift        : std_logic_vector(15 downto 0);

begin

    shift <= reg_in;

    LINEAR_FEEDBACK_SHIFT_REGISTER  :   process(clock, reset)
        begin
            if(reset = '0') then
                shift <= reg_in;
            elsif(rising_edge(clock)) then
                shift(15) <= shift(0);
                if(enable = '1') then
                    shift(14) <= shift(15) xor shift(0);
                else
                    shift(14) <= shift(15);
                end if;
                shift(13 downto 0) <= shift(14 downto 1);
            end if;
        end process;
     
     lfsr_out <= shift;           

end lfsr_arch;
