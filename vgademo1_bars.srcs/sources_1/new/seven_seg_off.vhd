----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2017 02:43:57 PM
-- Design Name: 
-- Module Name: seven_seg_off - Behavioral
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

entity seven_seg_off is
  Port (an_sel : out std_logic_vector(3 downto 0);
        clk : in std_logic);
end seven_seg_off;

architecture Behavioral of seven_seg_off is
--This process only turns the seven segment LEDs off
begin
  process(clk)
  begin
    if rising_edge(clk) then
      an_sel <= "1111";
  end if;
end process;



end Behavioral;
