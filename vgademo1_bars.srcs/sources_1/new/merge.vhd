----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2016 04:30:17 PM
-- Design Name: 
-- Module Name: merge_display - Behavioral
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

entity merge_display is
  Port (clk : in STD_LOGIC;
        Red_w,Red_b,Red_s,Red_l : in STD_LOGIC_VECTOR(3 downto 0);
        Green_w,Green_b,Green_s,Green_l : in STD_LOGIC_VECTOR(3 downto 0);
        Blue_w,Blue_b,Blue_s,Blue_l : in STD_LOGIC_VECTOR(3 downto 0);
        RED, GREEN, BLUE : out STD_LOGIC_VECTOR(3 downto 0));
end merge_display;

architecture Behavioral of merge_display is
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if (Red_w & Green_w & Blue_w /= "000000000000") then
        RED(3) <= Red_w(3);
        RED(2) <= Red_w(2);
        RED(1) <= Red_w(1);
        RED(0) <= Red_w(0);
        
        GREEN(3) <= Green_w(3);
        GREEN(2) <= Green_w(2);
        GREEN(1) <= Green_w(1);
        GREEN(0) <= Green_w(0);
        
        BLUE(3) <= Blue_w(3);
        BLUE(2) <= Blue_w(2);
        BLUE(1) <= Blue_w(1);
        BLUE(0) <= Blue_w(0);
      elsif (Red_s & Green_s & Blue_s /= "000000000000") then
        RED(3) <= Red_s(3);
        RED(2) <= Red_s(2);
        RED(1) <= Red_s(1);
        RED(0) <= Red_s(0);
        
        GREEN(3) <= Green_s(3);
        GREEN(2) <= Green_s(2);
        GREEN(1) <= Green_s(1);
        GREEN(0) <= Green_s(0);
        
        BLUE(3) <= Blue_s(3);
        BLUE(2) <= Blue_s(2);
        BLUE(1) <= Blue_s(1);
        BLUE(0) <= Blue_s(0);
      else
        RED(3) <= Red_b(3);
        RED(2) <= Red_b(2);
        RED(1) <= Red_b(1);
        RED(0) <= Red_b(0);
        
        GREEN(3) <= Green_b(3);
        GREEN(2) <= Green_b(2);
        GREEN(1) <= Green_b(1);
        GREEN(0) <= Green_b(0);
        
        BLUE(3) <= Blue_b(3);
        BLUE(2) <= Blue_b(2);
        BLUE(1) <= Blue_b(1);
        BLUE(0) <= Blue_b(0);

      end if;
    end if;
  end process;


end Behavioral;
