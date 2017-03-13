----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2017 02:35:31 PM
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Wario_logic is
  Port (btn, clk, vs, collide : in std_logic;
        btn_press : out std_logic;
        speed, punch : out integer;
        hcount, vcount : in STD_LOGIC_VECTOR(10 downto 0);
        Red, Green, Blue : out STD_LOGIC_VECTOR(3 downto 0));
end Wario_logic;

component debouncer is
  port(clk : in std_logic;
       btn_in : in std_logic;
       btn_out : out std_logic);
end component;


signal btn_temp : std_logic := '0';
signal btn_out : std_logic;

architecture Behavioral of Wario_logic is

  D1 : debouncer port map (clk => clk, btn_in => btn, btn_out => btn_out);


begin
btn_press <= btn_temp;
  -- level 3 has 7 punches before it flips
  -- Punch states: -1 = reset
  --               8 = punch 1, 7 = punch 2, 6 = punch 3, etc...
  --  10 = before punching starts

  state_machine : process(clk)
    variable state : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    variable count : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
  begin
    if rising_edge(clk, vs) then
      count := count + 1;
      case state is
        when "00000" => -- reset state runs for 3ms
          if count = "1111111111111111" then state <= "0001";
          end if;
          Red <= X"f"; Green <= X"f"; Blue <= X"f";
          punch <= -1; speed <= -1;
        when "00001" =>
          punch <= 10;
          if btn_out = '1' then
            state <= "00010";
          end if;
        when "00010" =>
          punch <= 8; 
          if collide = '1' then -- if the ball gets punched
            state <= "00011";
          else
            state <= "11111"; -- missed a punch,
            count <= "0000000000000000"; -- if you fail needs a few seconds to make it known
          end if;
        when "00011" =>
          punch <= 7;
          if collide = '1' then
            state <= "00100";
          else
            state <= "11111";
            count <= "0000000000000000";
          end if;
        when "00100" =>
          punch <= 6;
          if collide = '1' then
            state <= "00101";
          else
            state <= "11111";
            count <= "0000000000000000";
          end if;
        when "00101" =>
          punch <= 5;
          if collide = '1' then
            state <= "00111";
          else
            state <= "11111";
            count <= "0000000000000000";
          end if;
        when "00111" =>
          punch <= 4;
          if collide = '1' then
            state <= "01000";
          else
            state <= "11111";
            count <= "0000000000000000";
          end if;
        when "01000" =>
          punch <= 3;
          if collide = '1' then
            state <= "01001";
          else
            state <= "11111";
            count <= "0000000000000000";
          end if;
        when "01001" =>
          punch <= 2;
          if collide = '1' then
            state <= "01010";
          else
            state <= "11111";
            count <= "0000000000000000";
          end if;
        when "01010" => -- this is the final circle
          punch <= 1;
          
        when "11111" => --failure state
          punch <= -1;

      end case;
    end if;

    --100110001001011010000 is 50 ms in binary
    --when the button is pressed it only holds 
    btn_counter : process(clk) -- this goes with the logic, if the button is
      variable count : STD_LOGIC_VECTOR (20 downto 0) := "000000000000000000000";
      variable state : STD_LOGIC_VECTOR (1 downto 0) := "00";
    begin
      if rising_edge(clk) then
        count <= count + 1;
        case state is
          when "00" =>
            count := "000000000000000000000";
            btn_press <= '0';
            if btn_out = '1' then
              state := "01";
            else state := "00";
            end if;
          when "01" =>
            btn_press <= '1'; -- set button press output high for 50 ms
            if count >= "100110001001011010000" or btn_out = '0'then
              state := "10";
            else state := "01";
            end if;
          when "10" =>
            btn_press <= '0'; -- after 50 ms button press goes low, so you cant
                              -- hold it
            if btn_out = '1' then
              state := "10";
            else
              state := "00";
            end if;
        end case;
      end process;
                      
end Behavioral;
