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
  Port (btn_stop, clk, reset : in STD_LOGIC;
        collide : in STD_LOGIC_VECTOR (1 downto 0) := "00";
        punch : inout integer := 3;
        angle : inout integer);
end Wario_logic;

architecture Behavioral of Wario_logic is
  signal state : integer := 10;

begin
-- State machine to control which punch the game is on and to what angle 
  punch_proc : process(clk, collide, punch, state)
  begin
    if reset = '1' then
      state <= 10;
    elsif rising_edge(clk) then
      case state is -- state corresponds the the punch number
        when 10 => --before the first punch it just hangs
          if collide = "01" then
            state <= 8;
          elsif collide = "00" then
            state <= state;
            punch <= 10;
          elsif collide = "10" then
            state <= 7;
--          else state <= state;    
          end if;
        when 8 => --first punch, the slowest and lowest angle
          if collide = "01" then
            state <= 7;
          elsif collide = "00" then
            state <= state;
            punch <= 8;
            angle <= 30;
          elsif collide = "10" then
            state <= 0;
  --        else state <= state;
          end if;
        when 7 =>
          if collide = "01" then
            state <= 6;
          elsif collide = "00" then
            state <= state;
            punch <= 7;
            angle <= 45;
          elsif collide = "10" then
            state <= 0;
          --        else state <= state;
          end if;
        when 6 =>
          if collide = "01" then
            state <= 5;
          elsif collide = "00" then
            state <= state;
            punch <= 6;
            angle <= 75;
          elsif collide = "10" then
            state <= state;
          end if;
        when 5 =>
          if collide = "01" then
            state <= 4;
          elsif collide = "00" then
            state <= state;
            punch <= 5;
            angle <= 95;
          elsif collide = "10" then
            state <= state;
          end if;
          when others => state <= 10;
      end case;



      -- if collide = "01" and punch = 3 then -- if successful punch move to next
      --   punch <= 2;
      --   angle <= 70;
      -- elsif
      --   collide = "01" and punch = 2 then
      --   punch <= 1;
      --   angle <= 100;
      -- elsif collide = "01" and punch = 1 then
      --   punch <= 0;
      --   --angle <= 100;
      -- elsif collide = "10" and (punch = 5 or punch = 3 or punch = 2 or punch = 1) then
      --   punch <= 5;
      --   angle <= 180;
      -- elsif punch = 5 and collide = "01" then
      --   punch <= 3;
      --   angle <= 40;
      -- elsif punch = 0 then-- this needs to be removed
      --   punch <= 3;
      --   angle <= 40;
      -- else
      --   punch <= punch;
      -- end if;
    end if;
  end process;


end Behavioral;
