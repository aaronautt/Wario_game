----------------------------------------------------------------------------------
-- Engineer: Aaron Crump 
-- Class: EGR 426
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
use IEEE.STD_LOGIC_unsigned.ALL;

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
        angle_flag : in std_logic;
        invert, back_invert : out std_logic := '0');
end Wario_logic;

architecture Behavioral of Wario_logic is
  signal state : integer := 10;
  signal count : STD_LOGIC_VECTOR(22 downto 0);
  signal invert_temp : std_logic := '0';
  signal back_invert_temp : std_logic := '0';

begin
  invert <= invert_temp;
  back_invert <= back_invert_temp;

  -- State machine to control which punch the game is on and to what angle
  -- The ball swings up to   
  punch_proc : process(clk, collide, state, btn_stop)
  begin
    if reset = '1' then
      state <= 10;
    elsif rising_edge(clk) then
      count <= count + 1;
      case state is 
        when 10 => --before the first punch it just hang
          invert_temp <= '0'; -- keep color invert flags low until win or lose
          back_invert_temp <= '0';
          if btn_stop = '0' then
            increase <= "10";
          elsif btn_stop = '1' then
            state <= 11;
          else state <= 10;    
          end if;
        when 11 =>
          if btn_stop = '1' then
            state <= state;
          elsif btn_stop = '0' then -- doesn't move to the next state til
                                    -- button is low
            state <= 8;
           end if;
        when 8 => --first punch, the slowest and lowest angle
            angle <= 30; -- sets the angle
            punch <= 8; -- sets the punch speed 
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
            state <= 15;
            count <= "00000000000000000000000";
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
            state <= 15;
            count <= "00000000000000000000000";
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
            state <= 15;
            count <= "00000000000000000000000";
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
            state <= 15;
            count <= "00000000000000000000000";
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
            state <= 15;
            count <= "00000000000000000000000";
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
            state <= 15;
            count <= "00000000000000000000000";
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
            state <= 15;
            count <= "00000000000000000000000";
          end if;
        when 16 => 
          punch <= 1;
          angle <= 180;
          if angle_flag = '0' then
            increase <= "01";
          elsif angle_flag = '1' then
            increase <= "11";
            state <= 23;
          end if;
        when 15 =>
          invert_temp <= '1';
          increase <= "10";
          state <= 22;
        when 22 =>
          if count = "10111110101111000010000" then
            invert_temp <= not invert_temp;
            count <= "00000000000000000000000";
          elsif reset = '1' then
            state <= 10;
          end if;
        when 23 =>
          back_invert_temp <= '1';
          increase <= "11";
          if reset = '1' then
            state <= 10;
          end if;
        when others => state <= 10;
      end case;
    end if;
  end process;


end Behavioral;
