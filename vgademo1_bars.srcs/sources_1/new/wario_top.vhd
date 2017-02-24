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
Port(clk_100MHz,reset : in STD_LOGIC; 
     HSYNC,VSYNC,locked : out STD_LOGIC;
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

component colorbars is
Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank : in STD_LOGIC;
      Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
end component;

signal clk_25MHz,blank : STD_LOGIC;
signal hcount,vcount : STD_LOGIC_VECTOR(10 downto 0);
-- ---------------------------------------------------------------------
begin
c1 : clk_wiz_0 PORT MAP (clk_in1 => clk_100MHz, reset => reset, clk_out1 => clk_25MHz,
                         locked => locked);

v1 : vga_controller_640_60 PORT MAP (pixel_clk => clk_25MHz, rst => reset, HS => HSYNC, 
                                     VS => VSYNC, blank => blank, hcount => hcount, 
                                     vcount => vcount);

b1 : colorbars PORT MAP (hcount => hcount, vcount => vcount, blank => blank,
                         Red => RED, Green => GREEN, Blue => BLUE);

end Behavioral;
