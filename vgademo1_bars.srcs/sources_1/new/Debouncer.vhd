------------------------------------------------------------------------------------ 
---- Engineer: Aaron Crump
---- Class: EGR 426
---- Create Date: 01/30/2017 10:07:25 AM
---- Design Name: 
---- Module Name: debouncer - Behavioral
---- Project Name: Wario_game
------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer is
    port(clk : in std_logic;
         btn_in : in std_logic;
         btn_out, btn_stop : out std_logic);
end debouncer;

architecture Behavioral of debouncer is
signal latch : std_logic := '0'; -- latch signal for double verification of button press
signal DB_count : std_logic_vector (15 downto 0) := "0000000000000000";
signal TM_count : std_logic_vector (23 downto 0) := "000000000000000000000000";

begin
    process(btn_in, clk) -- counts up to 65535 on 25MHz clock cycles, if 0 detected it resets
        begin
        if rising_edge(clk) then
            if btn_in = '1' and latch = '0' then
                DB_count <= DB_count + 1;
                if DB_count = "1111111111111111" and btn_in = '1' then 
                latch <= '1';
                DB_count <= "0000000000000000";
                end if;
            elsif btn_in = '0' then
                latch <= '0';
                DB_count <= "0000000000000000";
            else null;
            end if;
         end if;
    end process;
    
    process(latch, btn_in) -- once DB_count reaches 65535 the latch is set, the button is only "depressed" if latch is set and button is pressed
        begin
        if latch = '1' then
            if btn_in = '1' then
                btn_out <= '1';
            elsif btn_in = '0' then
--                latch <= '0';
                btn_out <= '0';
            end if;
        --else btn_out <= '0';
        end if;
    end process;


    --101111101011110000100000 -- .5 seconds in binary
    process(latch, btn_in, clk)
    begin
      if rising_edge(clk) then
        TM_count <= TM_count + 1;
        if latch = '1' then
          if btn_in = '1' then
            btn_stop <= '1';
          elsif btn_in = '0' or TM_count = "101111101011110000100000" then
--                latch <= '0';
            TM_count <= "000000000000000000000000";
            btn_stop <= '0';
          end if;
        else TM_count <= "000000000000000000000000";
        end if;
      end if;
    end process;

        

end Behavioral;
