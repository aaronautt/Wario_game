----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2017 05:53:05 PM
-- Design Name: 
-- Module Name: line_draw - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity line_draw is
  Port (clk : in STD_LOGIC;
        xend,yend : in INTEGER;
        xpixel,ypixel : out STD_LOGIC_VECTOR (149 downto 0) := (others => '0'));
end line_draw;

architecture Behavioral of line_draw is

  constant xcenter : INTEGER := 320;
  constant ycenter : INTEGER := 250;

  signal dx, dy, tdy, tdx, steps : INTEGER;
  signal position : STD_LOGIC_VECTOR (149 downto 0) := (others => '0');
begin
  process(xend, yend)
  begin
    --if rising_edge(clk) then
    xpixel(0) <= xcenter;
    ypixel(0) <= ycenter;
    dx <= xcenter - xend;
    dy <= ycenter - yend;
    tdy <= 2*dy;
    tdx <= 2*dx;
    position(0) <= tdy - dx;
    for i in 0 to (dx-1)  loop
      if position(i) < 0 then
        xpixel(i+1) <= xpixel(i) + 1;
        ypixel(i+1) <= ypixel(i);
        position(i + 1) <= position(i) + tdy;
      else
        xpixel(i+1) <= xpixel(i);
        ypixel(i+1) <= ypixel(i) + 1;
      end if;
    end loop;
  end process;






end Behavioral;
