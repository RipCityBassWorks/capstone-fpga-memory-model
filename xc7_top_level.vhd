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
        --Reset signal
        ck_rst              : in    std_logic;
        --Switches
        sw                  : in    std_logic_vector(3 downto 0);
        --LEDs
        led                 : out   std_logic_vector(3 downto 0);
        --RGB LEDs
        led0_b              : out	std_logic;
        led0_g              : out	std_logic;
        led0_r              : out	std_logic;
        led1_b              : out	std_logic;
        led1_g              : out	std_logic;
        led1_r              : out	std_logic;
        led2_b              : out	std_logic;
        led2_g              : out	std_logic;
        led2_r              : out	std_logic;
        led3_b              : out	std_logic;
        led3_g              : out	std_logic;
        led3_r              : out	std_logic;
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
            en              : in    std_logic;
            reg_in          : in    std_logic_vector(15 downto 0);
            lfsr_out        : out   std_logic_vector(15 downto 0);
            random_out      : out   std_logic_vector(15 downto 0)
        );
    end component lfsr;
    
    component memory is
        Port( 
            clk             : in    std_logic;
            reset           : in    std_logic;
            event_en        : in    std_logic;
            data_in         : in    std_logic_vector(15 downto 0);
            data_out        : out   std_logic_vector(15 downto 0) 
        );
    end component memory;
    
    component btn_debounce is 
        port(
            clock           : in    std_logic;
            reset           : in    std_logic;
            pb_in           : in    std_logic;
            pb_out          : out   std_logic
        );
    end component btn_debounce;
    
--SIGNALS    
    signal clock            : std_logic;
    signal reset            : std_logic                         := sw(3);--ck_rst;
    --btn(0) debounced
    signal pb_0             : std_logic;   
    --btn(1) debounced     
    signal pb_1             : std_logic;
    --btn(2) debounced
    signal pb_2             : std_logic;
    --btn(3) debounced
    signal pb_3             : std_logic;
    signal event_en         : std_logic                         := pb_0;
    signal mem_block_in     : std_logic_vector(15 downto 0);
    signal mem_block_out    : std_logic_vector(15 downto 0);
    signal reg_in           : std_logic_vector(15 downto 0)     := "1110000100000000";  
    signal random_out       : std_logic_vector(15 downto 0);
    signal sys_clks_sec     : std_logic_vector(31 downto 0)     := "00000101111101011110000100000000";            

begin    
    
    PUSH_BUTTON_ZERO    :   btn_debounce
        port map(
            clock       => CLK100MHZ,
            reset       => reset,
            pb_in       => btn(0),
            pb_out      => pb_0
        );
    
    PUSH_BUTTON_ONE    :   btn_debounce
        port map(
            clock       => CLK100MHZ,
            reset       => reset,
            pb_in       => btn(1),
            pb_out      => pb_1
        ); 
        
    PUSH_BUTTON_TWO    :   btn_debounce
        port map(
            clock       => CLK100MHZ,
            reset       => reset,
            pb_in       => btn(2),
            pb_out      => pb_2
        );  
    
    PUSH_BUTTON_THREE    :   btn_debounce
        port map(
            clock       => CLK100MHZ,
            reset       => reset,
            pb_in       => btn(3),
            pb_out      => pb_3
        ); 
        
    DIVIDE_CLOCK    :   clock_divider   
        port map(
            clk_in      => CLK100MHZ, 
            reset       => reset, 
            sel         => sw(1 downto 0), 
            clk_out     => clock
        );
    
    LED_DECODE      :   led_decoder
        port map(
            clk         => clock,
            reset       => reset,
            mem_block   => mem_block_out(7 downto 0), --random_out(7 downto 0),
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
            clock       => clock,
            en          => event_en,
            reset       => reset,      
            reg_in      => reg_in,   
            lfsr_out    => mem_block_in,
            random_out  => random_out 
        );
    
    RW_MEMORY       :   memory
        port map(
            clk         => clock,
            reset       => reset,
            event_en    => event_en,
            data_in     => random_out,
            data_out    => mem_block_out
        );
        
                   
    
end xc7_top_level_arch;
