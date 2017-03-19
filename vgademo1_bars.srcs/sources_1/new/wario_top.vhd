----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2016 04:32:11 PM
-- Design Name: 
-- Module Name: vgademo1_bars_top - Behavioral
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
entity vgademo1_bars_top is
Port(clk_100MHz, reset, btn_in : in STD_LOGIC; 
     HSYNC,VSYNC,LED : out STD_LOGIC;
     RED,GREEN,BLUE : out STD_LOGIC_VECTOR(3 downto 0);
     an_sel : out STD_LOGIC_VECTOR(3 downto 0));
end vgademo1_bars_top;


architecture Behavioral of vgademo1_bars_top is
-- ---------------------------------------------------------------------
component clk_wiz_0
port(clk_in1,reset : in std_logic; clk_out1,locked : out std_logic);
end component;

component vga_controller_640_60 is
port(rst,pixel_clk : in std_logic; HS,VS,blank : out std_logic;
     hcount,vcount : out std_logic_vector(10 downto 0));
end component;

component background is
  Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0);
        blank, back_invert : in STD_LOGIC;
        Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component merge_display is
  Port (clk : in STD_LOGIC;
        Red_w,Red_b, Red_s, Red_p : in STD_LOGIC_VECTOR(3 downto 0);
        Green_w,Green_b, Green_s, Green_p : in STD_LOGIC_VECTOR(3 downto 0);
        Blue_w,Blue_b, Blue_s, Blue_p : in STD_LOGIC_VECTOR(3 downto 0);
        Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0);
        circle_on, pic_on, word_on : in STD_LOGIC);
end component;

component words is
  PORT(clk25, blank, vs : in STD_LOGIC; hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); 
       Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0);
       word_on : out STD_LOGIC);
end component;

component swing is
  Port (vs, blank, clk, btn, reset : in std_logic;
        hcount, vcount : in STD_LOGIC_VECTOR(10 downto 0);
        LED, circle_on, invert, back_invert : out std_logic;
        Red, Green, Blue : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component MY_PIXEL_DRIVER is
  Port (clk25 : in STD_LOGIC; hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); 
        blank, invert : in STD_LOGIC;
        pic_on : out std_logic;
        Red, Green, Blue : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component seven_seg_off is
  Port (an_sel : out std_logic_vector(3 downto 0);
        clk : in std_logic);
end component;


signal clk_25MHz, blank, VS, btn_out, invert, back_invert : STD_LOGIC;
signal hcount,vcount : STD_LOGIC_VECTOR(10 downto 0);
signal RED_w,GREEN_w,BLUE_w : STD_LOGIC_VECTOR(3 downto 0);
signal RED_b,GREEN_b,BLUE_b : STD_LOGIC_VECTOR(3 downto 0);
signal RED_s,GREEN_s,BLUE_s : STD_LOGIC_VECTOR(3 downto 0);
signal RED_p,GREEN_p,BLUE_p : STD_LOGIC_VECTOR(3 downto 0);
signal circle_on, pic_on, word_on : std_logic;
signal locked : std_logic;-- dummy signal to take locked led signall


-- ---------------------------------------------------------------------
begin
S2 : seven_seg_off port map (clk => clk_25MHz, an_sel => an_sel);

P1 : MY_PIXEL_DRIVER port map(clk25 => clk_25MHz, hcount => hcount, vcount => vcount,
                              blank => blank, Red => RED_p, Green => GREEN_p, Blue => BLUE_p,
                              pic_on => pic_on, invert => invert);

c1 : clk_wiz_0 PORT MAP (clk_in1 => clk_100MHz, reset => reset, clk_out1 => clk_25MHz,
                        locked => locked); --leaving locked unconnected so all
                         --the LEDs are off

v1 : vga_controller_640_60 PORT MAP (pixel_clk => clk_25MHz, rst => reset, HS => HSYNC, 
                                     VS => VSYNC, blank => blank, hcount => hcount, 
                                     vcount => vcount);

b1 : background PORT MAP (hcount => hcount, vcount => vcount, blank => blank,
                          Red => RED_b, Green => GREEN_b, Blue => BLUE_b,
                          back_invert => back_invert);

m1 : merge_display PORT MAP (clk => clk_25MHz, Red_w => RED_w, Red_b => RED_b, Red_s => RED_s, Red_p => RED_p,
                             Green_w => GREEN_w, Green_b => GREEN_b, Green_s => GREEN_s, Green_p => GREEN_p,
                             Blue_w => BLUE_w, Blue_b => BLUE_b, Blue_s => BLUE_s, Blue_p => BLUE_p,
                             red => red, green => green, blue => blue,
                             circle_on => circle_on, pic_on => pic_on, word_on => word_on);

W1 : words PORT MAP (clk25 => clk_25MHZ, vs => VS, blank => blank, hcount => hcount,
                     vcount => vcount, Red => RED_w, Green => GREEN_w, Blue => BLUE_w, word_on => word_on);

S1 : swing port map (vs => VS, clk => clk_25MHz, blank => blank, hcount => hcount, vcount => vcount,
                     Red => RED_s, Green => GREEN_s, Blue => BLUE_S, LED => LED, btn => btn_in,
                     reset => reset, circle_on => circle_on, invert => invert, back_invert => back_invert);


VSYNC <= VS;

end Behavioral;

