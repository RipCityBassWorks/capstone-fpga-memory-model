----------------------------------------------------------------------------------
-- Stefan Andersson
-- 
-- Create Date: 10/28/2018 07:17:23 PM
-- Design Name: clock_divider.vhd
-- Module Name: clock_divider - clock_divider_arch
-- Project Name: capstone-fpga-memory-model
-- Target Devices: XC7A35TICSG324-1L
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
use IEEE.NUMERIC_STD.ALL;


entity clock_divider is
    port(
        clk_in          : in    std_logic;
        reset           : in    std_logic;
        sel             : in    std_logic_vector(1 downto 0);
        clk_out         : out   std_logic
    );
end clock_divider;

architecture clock_divider_arch of clock_divider is
    
    signal cnt_int      : integer;
    signal clk          : std_logic;
    
begin

    process(clk_in, reset)
        begin
            if(reset = '0') then
                cnt_int <= 0;
                clk     <= '0';
            elsif(rising_edge(clk_in)) then
                --1Hz clock
                --period = 1sec
                --counts = 100,000,000
                if(sel = "00") then
                    if(cnt_int = 99999999) then
                        cnt_int <= 0;
                        clk     <= not clk;
                    else
                        cnt_int <= cnt_int + 1;
                    end if;
                    
                --10Hz clock
                --period = 0.1sec
                --counts = 10,000,000
                elsif(sel = "01") then
                    if(cnt_int = 9999999) then
                        cnt_int <= 0;
                        clk     <= not clk;
                    else
                        cnt_int <= cnt_int + 1;
                    end if;
                    
                --100Hz clock
                --period = 0.01sec
                --counts = 1,000,000
                elsif(sel = "10") then
                    if(cnt_int = 999999) then
                        cnt_int <= 0;
                        clk     <= not clk;
                    else
                        cnt_int <= cnt_int + 1;
                    end if;
                    
                --1kHz clock
                --period = 0.001sec
                --counts = 100,000
                elsif(sel = "11") then
                    if(cnt_int = 99999) then
                        cnt_int <= 0;
                        clk     <= not clk;
                    else
                        cnt_int <= cnt_int + 1;
                    end if;
                end if;
            end if;
    end process;
    
    clk_out <= clk;
    
end clock_divider_arch;
