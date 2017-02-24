----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2016 04:30:49 PM
-- Design Name: 
-- Module Name: colorbars - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;
--use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity colorbars is
Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank : in STD_LOGIC;
      Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
end colorbars;

architecture Behavioral of colorbars is
begin
  process(hcount,vcount,blank)
    VARIABLE row, col : INTEGER;
  begin
    row := conv_integer(vcount);
    col := conv_integer(hcount);

    if (row > 445 and blank = '0') then
      Red <= "1100"; Green <= "0011"; Blue <= "0000";
    elsif (row > 435 and row <= 445) and blank = '0' then
      Red <= "0100"; Green <= "0001"; Blue <= "0000";
    elsif (col < (320 - (row/2))) and blank = '0' then
      Red <= "0111"; Green <= "0111"; Blue <= "0000";
    elsif (col > (320 + (row/2))) and blank = '0' then
      Red <= "0111"; Green <= "0111"; Blue <= "0000";
    elsif  (480*row-row*row+640*col-col*col)> 157696   then
      Red <= "1010"; Green <= "1010"; Blue <= "1010"; 
    elsif blank = '0' then
      Red <= "1111"; Green <= "1111"; Blue <= "0000";
    else
      Red <= "0000"; Green <= "0000"; Blue <= "0000";
    end if;
  end process;


-- Red <= "1111"  when (vcount < 60 and blank='0') 
--				or (vcount >=120 and vcount < 200 and blank='0')
--				or (vcount >= 280 and vcount < 360 and blank='0')
--				or (vcount >= 440 and vcount < 520 and blank='0') 
--				else "0000";

-- Green <= "1111" when (vcount >= 60 and vcount < 200 and blank='0')
--				 or (vcount >= 360 and vcount < 520 and blank='0') 
--				 else "0000";
				 
-- Blue <= "1111" when ((vcount >= 200 and vcount < 520 and blank='0'))
--                else "0000";

end Behavioral;
