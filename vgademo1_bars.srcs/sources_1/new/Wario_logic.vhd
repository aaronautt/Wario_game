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
  Port (btn, clk, vs : in std_logic;
        btn_press, LED : out std_logic;
        speed, punch : out integer;
        collide : in STD_LOGIC_VECTOR (1 downto 0);
        hcount, vcount : in STD_LOGIC_VECTOR(10 downto 0);
        Red, Green, Blue : out STD_LOGIC_VECTOR(3 downto 0));
end Wario_logic;

architecture Behavioral of Wario_logic is

component debouncer is
  port(clk : in std_logic;
       btn_in : in std_logic;
       btn_out : out std_logic);
end component;


signal btn_temp : std_logic := '0';
signal btn_out : std_logic;
signal btn_count : STD_LOGIC_VECTOR (20 downto 0) := "000000000000000000000";
signal btn_state : STD_LOGIC_VECTOR (1 downto 0) := "00";
signal state : STD_LOGIC_VECTOR (4 downto 0) := "00010";
signal count : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";




begin

punch <= 7;
  D1 : debouncer port map (clk => clk, btn_in => btn, btn_out => btn_out);  
 -- btn_press <= btn_temp;
  -- level 3 has 7 punches before it flips
  -- Punch states: -1 = reset
  --               8 = punch 1, 7 = punch 2, 6 = punch 3, etc...
  --  10 = before punching starts

  -- LED_debug : process(btn_out)
  -- begin
  --   if btn_out = '1' then
  --     LED <= '1';
  --   else LED <= '0';
  --   end if;
  -- end process;

 --  state_machine : process(clk, btn_out)
 --  begin
 --    if rising_edge(clk) then
 --      --count <= count + 1;
 --      case state is
 --        -- when "00000" => -- reset state runs for 3ms
 --        --   if count = "1111111111111111" then state <= "00001";
 --        --   end if;
 --        --   Red <= X"f"; Green <= X"f"; Blue <= X"f";
 --        --   punch <= -1; speed <= -1;
 --        when "00001" =>
 --          punch <= 10;
 --          if btn_out = '1' then
 --            state <= "00010";
 --          end if;
 --        when "00010" =>
 --          punch <= 8;
 --          if collide = "10" then
 --            state <= state;
 --          elsif collide = "01" then -- if the ball gets punched
 --            state <= "00011";
 --          else
 --            state <= "00001"; -- missed a punch,
 --            --count <= "0000000000000000"; -- if you fail needs a few seconds to make it known
 --          end if;
 --        when "00011" =>
 --          punch <= 7;
 --          if collide = "10" then
 --            state <= state;
 --          elsif collide = "01" then
 --            state <= "00001";
 --          else
 --            state <= "11111";
 --            --count <= "0000000000000000";
 --          end if;

 --          when others => null;
          
 --          end case;
 --          end if;
 -- end process;  

  -- state_machine : process(clk, btn_out)
  -- begin
  --   if rising_edge(clk) then
  --     count <= count + 1;
  --     case state is
  --       when "00000" => -- reset state runs for 3ms
  --         if count = "1111111111111111" then state <= "00001";
  --         end if;
  --         Red <= X"f"; Green <= X"f"; Blue <= X"f";
  --         punch <= -1; speed <= -1;
  --       when "00001" =>
  --         punch <= 10;
  --         if btn_out = '1' then
  --           state <= "00010";
  --         end if;
  --       when "00010" =>
  --         punch <= 8;
  --         if collide = "10" then
  --           state <= state;
  --         elsif collide = "01" then -- if the ball gets punched
  --           state <= "00011";
  --         else
  --           state <= "11111"; -- missed a punch,
  --           count <= "0000000000000000"; -- if you fail needs a few seconds to make it known
  --         end if;
  --       when "00011" =>
  --         punch <= 7;
  --         if collide = "10" then
  --           state <= state;
  --         elsif collide = "01" then
  --           state <= "00100";
  --         else
  --           state <= "11111";
  --           count <= "0000000000000000";
  --         end if;
  --       when "00100" =>
  --         punch <= 6;
  --         if collide = "10" then
  --           state <= state;
  --         elsif collide = "01" then
  --           state <= "00101";
  --         else
  --           state <= "11111";
  --           count <= "0000000000000000";
  --         end if;
  --       when "00101" =>
  --         punch <= 5;
  --         if collide = "10" then
  --           state <= state;
  --         elsif collide = "01" then
  --           state <= "00111";
  --         else
  --           state <= "11111";
  --           count <= "0000000000000000";
  --         end if;
  --       when "00111" =>
  --         punch <= 4;
  --         if collide = "10" then
  --           state <= state;
  --         elsif collide = "01" then
  --           state <= "01000";
  --         else
  --           state <= "11111";
  --           count <= "0000000000000000";
  --         end if;
  --       when "01000" =>
  --         punch <= 3;
  --         if collide = "10" then
  --           state <= state;
  --         elsif collide = "01" then
  --           state <= "01001";
  --         else
  --           state <= "11111";
  --           count <= "0000000000000000";
  --         end if;
  --       when "01001" =>
  --         punch <= 2;
  --         if collide = "10" then
  --           state <= state;
  --         elsif collide = "01" then
  --           state <= "01010";
  --         else
  --           state <= "11111";
  --           count <= "0000000000000000";
  --         end if;
  --       when "01010" => -- this is the final circle, add something here
  --         punch <= 1;
  --         state <= "00000";
          
  --       when "11111" => --failure state, add something here
  --         punch <= -1;
  --         state <= "00000";
  --       when others =>
  --         null;
  --     end case;
  --   end if;
  --   end process;
    

    --100110001001011010000 is 50 ms in binary
    --when the button is pressed it only holds 
    btn_counter_proc : process(clk, btn_out) -- this goes with the logic, if the button is
    begin
      if rising_edge(clk) then
        btn_count <= btn_count + 1;
        case btn_state is
          when "00" =>
            btn_count <= "000000000000000000000";
            btn_press <= '0';
            if btn_out = '1' then
              btn_state <= "01";
            else btn_state <= "00";
            end if;
          when "01" =>
            btn_press <= '1'; -- set button press output high for 50 ms
            if btn_count >= "100110001001011010000" or btn_out = '0'then
              btn_state <= "10";
            else btn_state <= "01";
            end if;
          when "10" =>
            btn_press <= '0'; -- after 50 ms button press goes low, so you cant
                              -- hold it
            if btn_out = '1' then
              btn_state <= "10";
            else
              btn_state <= "00";
            end if;
          when others =>
            null;
        end case;
        end if;
      end process;
                      
end Behavioral;
