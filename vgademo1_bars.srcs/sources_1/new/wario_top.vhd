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
     HSYNC,VSYNC,locked : out STD_LOGIC;
     LED : out STD_LOGIC;
     RED,GREEN,BLUE : out STD_LOGIC_VECTOR(3 downto 0));
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
Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank : in STD_LOGIC;
      Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component merge_display is
  Port (clk : in STD_LOGIC;
        Red_w,Red_b, Red_s, Red_l : in STD_LOGIC_VECTOR(3 downto 0);
        Green_w,Green_b, Green_s, Green_l : in STD_LOGIC_VECTOR(3 downto 0);
        Blue_w,Blue_b, Blue_s, Blue_l : in STD_LOGIC_VECTOR(3 downto 0);
        Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component words is
  PORT(clk25, blank, vs : in STD_LOGIC; hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); 
       Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component swing is
  Port (vs, blank, clk, btn_press : in std_logic;
        punch : in integer;
        LED : out std_logic;
        collide : out STD_LOGIC_VECTOR(1 downto 0);
        hcount, vcount : in STD_LOGIC_VECTOR(10 downto 0);
        Red, Green, Blue : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component Wario_logic is
  Port (btn, clk, vs : in std_logic;
        btn_press, LED : out std_logic;
        speed, punch : out integer;
        collide : in STD_LOGIC_VECTOR(1 downto 0);
        hcount, vcount : in STD_LOGIC_VECTOR(10 downto 0);
        Red, Green, Blue : out STD_LOGIC_VECTOR(3 downto 0));
end component;


signal clk_25MHz, blank, VS, btn_out, btn_press : STD_LOGIC;
signal collide : STD_LOGIC_VECTOR (1 downto 0);
signal hcount,vcount : STD_LOGIC_VECTOR(10 downto 0);
signal RED_w,GREEN_w,BLUE_w : STD_LOGIC_VECTOR(3 downto 0);
signal RED_b,GREEN_b,BLUE_b : STD_LOGIC_VECTOR(3 downto 0);
signal RED_s,GREEN_s,BLUE_s : STD_LOGIC_VECTOR(3 downto 0);
signal speed, punch : integer;
signal RED_l,GREEN_l,BLUE_l : STD_LOGIC_VECTOR(3 downto 0);
--signal RED_t,GREEN_t,BLUE_t : STD_LOGIC_VECTOR(3 downto 0);


-- ---------------------------------------------------------------------
begin

c1 : clk_wiz_0 PORT MAP (clk_in1 => clk_100MHz, reset => reset, clk_out1 => clk_25MHz,
                         locked => locked);

v1 : vga_controller_640_60 PORT MAP (pixel_clk => clk_25MHz, rst => reset, HS => HSYNC, 
                                     VS => VSYNC, blank => blank, hcount => hcount, 
                                     vcount => vcount);

b1 : background PORT MAP (hcount => hcount, vcount => vcount, blank => blank,
                         Red => RED_b, Green => GREEN_b, Blue => BLUE_b);

m1 : merge_display PORT MAP (clk => clk_25MHz, Red_w => RED_w, Red_b => RED_b, Red_s => RED_s,
                             Green_w => GREEN_w, Green_b => GREEN_b, Green_s => GREEN_s,
                             Blue_w => BLUE_w, Blue_b => BLUE_b, Blue_s => BLUE_s,
                             Red_l => RED_l, Green_l => GREEN_l, Blue_l => BLUE_l,
                             red => red, green => green, blue => blue);

W1 : words PORT MAP (clk25 => clk_25MHZ, vs => VS, blank => blank, hcount => hcount,
                     vcount => vcount, Red => RED_w, Green => GREEN_w, Blue => BLUE_w);

S1 : swing port map (vs => VS, clk => clk_25MHz, blank => blank, hcount => hcount, vcount => vcount,
                     Red => RED_s, Green => GREEN_s, Blue => BLUE_s, collide => collide,
                     btn_press => btn_press, punch => punch, LED => LED);

W2 : Wario_logic port map (btn => btn_in, clk => clk_25MHz, vs => VS, speed => speed,
                           punch => punch, hcount => hcount, vcount => vcount, btn_press => btn_press,
                           Red => RED_l, Green => GREEN_l, Blue => BLUE_l, collide => collide, LED => LED);

VSYNC <= VS;

end Behavioral;

