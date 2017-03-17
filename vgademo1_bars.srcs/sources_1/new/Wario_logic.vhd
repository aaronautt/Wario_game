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
        punch : inout integer;
        angle : out integer;
        increase : out STD_LOGIC_VECTOR(1 downto 0);
        angle_flag : in std_logic);
end Wario_logic;

architecture Behavioral of Wario_logic is
  signal state : integer := 10;

begin


-- State machine to control which punch the game is on and to what angle 
  punch_proc : process(clk, collide, state, btn_stop)
  begin
    if reset = '1' then
      state <= 10;
    elsif rising_edge(clk) then
      case state is -- state corresponds the the punch number
        when 10 => --before the first punch it just hang
          if btn_stop = '0' then
            increase <= "10";
          elsif btn_stop = '1' then
            state <= 11;
          else state <= 10;    
          end if;
        when 11 =>
          if btn_stop = '1' then
            state <= state;
          elsif btn_stop = '0' then
            state <= 8;
           end if;
        when 8 => --first punch, the slowest and lowest angle
            angle <= 30;
            punch <= 8;
          if angle_flag = '0' then
            increase <= "01";
          elsif angle_flag = '1' then
            increase <= "00";
            state <= 12;
          end if;
        when 12 =>
          if (collide = "01" or collide = "10") and btn_stop = '1' then
            state <= 7;
          elsif collide = "10" and btn_stop = '0' then
            state <= 10;
          end if;
        when 7 =>
          punch <= 7;
          angle <= 45;
          if angle_flag = '0' then
            increase <= "01";
          elsif angle_flag = '1' then
            increase <= "00";
            state <= 13;
          end if;
        when 13 =>
          if (collide = "01" or collide = "10") and btn_stop = '1' then
            state <= 6;
          elsif collide = "10" and btn_stop = '0' then
            state <= 10;
          end if;
        when 6 =>
          punch <= 6;
          angle <= 65;
          if angle_flag = '0' then
            increase <= "01";
          elsif angle_flag = '1' then
            increase <= "00";
            state <= 5;
          end if;
        when 5 =>
          if (collide = "01" or collide = "10") and btn_stop = '1' then
            state <= 4;
          elsif collide = "10" and btn_stop = '0' then
            state <= 10;
          end if;
        when 4 =>
          punch <= 5;
          angle <= 85;
          if angle_flag = '0' then
            increase <= "01";
          elsif angle_flag = '1' then
            increase <= "00";
            state <= 3;
          end if;
        when 3 =>
          if (collide = "01" or collide = "10") and btn_stop = '1' then
            state <= 2;
          elsif collide = "10" and btn_stop = '0' then
            state <= 10;
          end if;
        when 2 =>
          punch <= 4;
          angle <= 95;
          if angle_flag = '0' then
            increase <= "01";
          elsif angle_flag = '1' then
            increase <= "00";
            state <= 1;
          end if;
        when 1 =>
          if (collide = "01" or collide = "10") and btn_stop = '1' then
            state <= 20;
          elsif collide = "10" and btn_stop = '0' then
            state <= 10;
          end if;
        when 20 =>
          punch <= 3;
          angle <= 120;
          if angle_flag = '0' then
            increase <= "01";
          elsif angle_flag = '1' then
            increase <= "00";
            state <= 19;
          end if;
        when 19 =>
          if (collide = "01" or collide = "10") and btn_stop = '1' then
            state <= 18;
          elsif collide = "10" and btn_stop = '0' then
            state <= 10;
          end if;
        when 18 =>
          punch <= 2;
          angle <= 140;
          if angle_flag = '0' then
            increase <= "01";
          elsif angle_flag = '1' then
            increase <= "00";
            state <= 17;
          end if;
        when 17 =>
          if (collide = "01" or collide = "10") and btn_stop = '1' then
            state <= 16;
          elsif collide = "10" and btn_stop = '0' then
            state <= 10;
          end if;
        when 16 => -- put something here for a cooler endingG
          punch <= 1;
          angle <= 180;
          if angle_flag = '0' then
            increase <= "01";
          elsif angle_flag = '1' then
            increase <= "11";
            state <= 16;
          end if;
        when others => state <= 10;
      end case;
    end if;
  end process;


end Behavioral;
