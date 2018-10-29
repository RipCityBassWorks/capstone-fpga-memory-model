----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2018 07:51:19 PM
-- Design Name: 
-- Module Name: led_decoder - led_decoder_arch
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

entity led_decoder is
    port(
        clk             : in    std_logic;
        reset           : in    std_logic;
        mem_block       : in    std_logic_vector(15 downto 0);
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
end led_decoder;

architecture led_decoder_arch of led_decoder is
    
    signal led_vector   : std_logic_vector(15 downto 0);
    
begin
    
    process(clk, reset)
        begin
            if(reset = '0') then
                led_vector <= "0000000000000000";  
            elsif(rising_edge(clk)) then
                led_vector <= mem_block;  
            end if;
    end process;
    
        led         <= led_vector(3 downto 0);               
        led0_b      <= led_vector(4);
        led0_g      <= led_vector(5);
        led0_r      <= led_vector(6);
        led1_b      <= led_vector(7);
        led1_g      <= led_vector(8);
        led1_r      <= led_vector(9);
        led2_b      <= led_vector(10);
        led2_g      <= led_vector(11);
        led2_r      <= led_vector(12);
        led3_b      <= led_vector(13);
        led3_g      <= led_vector(14);
        led3_r      <= led_vector(15);      

end led_decoder_arch;
