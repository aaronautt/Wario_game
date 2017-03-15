----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2017 10:25:40 PM
-- Design Name: 
-- Module Name: Wario_logic - Behavioral
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

entity Wario_logic is
  Port (btn_stop, clk : in STD_LOGIC;
        collide : in STD_LOGIC_VECTOR (1 downto 0);
        punch, angle : inout integer);
end Wario_logic;

architecture Behavioral of Wario_logic is
  signal state : integer;

begin

  punch_proc : process(clk)
  begin
    if rising_edge(clk) then
      if collide = "01" and punch = 3 then -- if successful punch move to next
        punch <= 2;
      elsif
        collide = "01" and punch = 2 then
        punch <= 1;
      elsif collide = "01" and punch = 1 then
        punch <= 0;
      elsif collide = "10" and (punch = 5 or punch = 3 or punch = 2 or punch = 1) then
        punch <= 5;
      elsif punch = 5 and collide = "01" then
        punch <= 3;
      elsif punch = 0 then-- this needs to be removed
        punch <= 3;
      else
        punch <= punch;
      end if;
    end if;
  end process;


end Behavioral;
