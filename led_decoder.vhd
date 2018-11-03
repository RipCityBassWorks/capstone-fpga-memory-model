----------------------------------------------------------------------------------
-- Stefan Andersson
-- 
-- Create Date: 10/28/2018 07:51:19 PM
-- Design Name: led_decoder.vhd
-- Module Name: led_decoder - led_decoder_arch
-- Project Name: capstone-fpga-memory-model
-- Target Devices: XC7A35TICSG324-1L
-- Tool Versions: Vivado 2018.2
-- Description: Decodes an 8 bit binary number
-- to an ouput sequence for the on board LEDs
-- and displays the output for 4 secs
-- Component of xc7_top_level.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_decoder is
    port(
        clk             : in    std_logic;
        reset           : in    std_logic;
        mem_block       : in    std_logic_vector(7 downto 0);
        led             : out   std_logic_vector(3 downto 0);               
        led0_b          : out	std_logic;
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
end  entity led_decoder;

architecture led_decoder_arch of led_decoder is
    
--COMPONENT DECLARATIONS
    component delay_counter is
    port(
        clock           : in    std_logic;
        reset           : in    std_logic;
        delay_out       : out   std_logic
    );
    end component delay_counter;

--SIGNALS  
    signal led_vector   : std_logic_vector(7 downto 0);
    signal delay_out    : std_logic;
    
begin
    
    FOUR_SEC_DELAY  :   delay_counter
        port map(
            clock       => clk,
            reset       => reset,
            delay_out   => delay_out
        );

--    process(clk, reset)
--        begin
--            if(reset = '0') then
--                led_vector <= "00000000";  
--            elsif(rising_edge(clk)) then
--                led_vector <= mem_block;  
--            end if;
--    end process;
    
    led_vector <= mem_block;
    
    process(clk, reset)
        begin
            if(rising_edge(clk)) then
                if(delay_out = '1') then
                    led0_b      <= led_vector(7);
                    led0_r      <= led_vector(6);
                    led1_b      <= led_vector(5);
                    led1_r      <= led_vector(4);
                    led2_b      <= led_vector(3);
                    led2_r      <= led_vector(2);
                    led3_b      <= led_vector(1);
                    led3_r      <= led_vector(0); 
                end if;
            end if;
    end process;
    
    led(3 downto 0)     <= led_vector(7 downto 4);
    led0_r              <= led_vector(0);
    led1_r              <= led_vector(1);
    led2_r              <= led_vector(2);
    led3_r              <= led_vector(3); 
    
                
end led_decoder_arch;
