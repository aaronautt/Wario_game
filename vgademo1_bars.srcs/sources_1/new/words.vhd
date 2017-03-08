----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2017 04:42:26 PM
-- Design Name: 
-- Module Name: words - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity words is
  PORT(clk25, blank, vs : in STD_LOGIC; hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); 
       Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
end words;



architecture Behavioral of words is

  signal pixel_row : STD_LOGIC_VECTOR(3 downto 0);
  signal pixel_col : STD_LOGIC_VECTOR(3 downto 0);

  signal ROM_ADDRESS : STD_LOGIC_VECTOR(7 downto 0);
  signal ROM_DATA : STD_LOGIC_VECTOR(15 downto 0);
  signal INTENSITY : STD_LOGIC;
  signal w_count : std_logic_vector(3 downto 0) := "0000";
  constant size : integer := 16;
  constant start : integer := 208;
  signal section : std_logic;


 COMPONENT blk_mem_gen_0
   PORT (
     clka : IN STD_LOGIC;
      addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
      );
  END COMPONENT;



begin
    rom : blk_mem_gen_0 PORT MAP (clka => clk25, addra => ROM_ADDRESS, douta => ROM_DATA);
    pixel_row <= vcount(3 downto 0);
    pixel_col <= hcount(3 downto 0);
    


--sparring Wario has 14 letters


addr_increment: process(vs)
  variable count : STD_LOGIC_VECTOR (3 downto 0);
  begin
  if vs'event and vs = '1' then
    count := count + 1;
    if count = "1111" then
      w_count <= w_count +1;
      if w_count = "1110" then w_count <= "0000";
      end if;
    end if; 
  end if;
end process;

print: process(clk25)
begin
  if rising_edge(clk25) then
  if (vcount < 16) and (hcount > start) and (hcount <= (start + size)) then
    
    ROM_ADDRESS <= "0000" & pixel_row;  -- Generating ROM address
    section <= '1';
    
  elsif (vcount < 16) and (hcount > (start + size)) and (hcount <= (start + 2*size)) then
    
    ROM_ADDRESS <= "0001" & pixel_row;  -- Generating ROM address
    section <= '1';
    
  elsif (vcount < 16) and (hcount > (start + 2*size)) and (hcount <= (start + 3*size)) then
    
    ROM_ADDRESS <= "0010" & pixel_row;  -- Generating ROM address
    section <= '1';
    
  elsif (vcount < 16) and (hcount > (start + 3*size)) and (hcount <= (start + 4*size)) then
    
    ROM_ADDRESS <= "0011" & pixel_row;  -- Generating ROM address
    section <= '1';
    
  elsif (vcount < 16) and (hcount > (start + 4*size)) and (hcount <= (start + 5*size)) then
    
    ROM_ADDRESS <= "0100" & pixel_row;  -- Generating ROM address
    section <= '1';
    
  elsif (vcount < 16) and (hcount > (start + 5*size)) and (hcount <= (start + 6*size)) then
    
    ROM_ADDRESS <= "0101" & pixel_row;  -- Generating ROM address
    section <= '1';
    
  elsif (vcount < 16) and (hcount > (start + 6*size)) and (hcount <= (start + 7*size)) then
    
    ROM_ADDRESS <= "0110" & pixel_row;  -- Generating ROM address
    section <= '1';
    
  elsif (vcount < 16) and (hcount > (start+ 7*size)) and (hcount <= (start +8*size)) then
    
    ROM_ADDRESS <= "0111" & pixel_row;  -- Generating ROM address
    section <= '1';
    
  elsif (vcount < 16) and (hcount > (start+ 8*size)) and (hcount <= (start +9*size)) then
    
    ROM_ADDRESS <= "1000" & pixel_row;  -- Generating ROM address
    section <= '1';
    
  elsif (vcount < 16) and (hcount > (start + 9*size)) and (hcount <= (start + 10*size)) then
    
    ROM_ADDRESS <= "1001" & pixel_row;  -- Generating ROM address
    section <= '1';
    
  elsif (vcount < 16) and (hcount > (start + 10*size)) and (hcount <= (start + 11*size)) then
    ROM_ADDRESS <= "1010" & pixel_row;  -- Generating ROM address
    section <= '1';
    
  elsif (vcount < 16) and (hcount > (start + 11*size)) and (hcount <= (start + 12*size)) then
    
    ROM_ADDRESS <= "1011" & pixel_row;  -- Generating ROM address
    section <= '1';
    
  elsif (vcount < 16) and (hcount > (start + 12*size)) and (hcount <= (start + 13*size)) then
    ROM_ADDRESS <= "1100" & pixel_row;  -- Generating ROM address
    section <= '1';    
  elsif (vcount < 16) and (hcount > (start + 13*size)) and (hcount <= (start + 14*size)) then    
    ROM_ADDRESS <= "1101" & pixel_row;  -- Generating ROM address
    section <= '1';
  else
    ROM_ADDRESS <= "00000000";
    section <= '0';
  end if;
end if;

end process;

process(clk25)      -- Process block to assign pixel values to GB
variable col1, col2, col3, col0 : integer range 0 to 15;
begin
  if(rising_edge(clk25)) then
    if(section = '1') then
      col3 := col2;
      col2 := col1;
      col1 := col0;
      col0 := conv_integer(pixel_col);
      INTENSITY <= ROM_DATA(col3);
    else
      INTENSITY <= '0';
    end if;
  end if;
end process;


Red <= (INTENSITY & INTENSITY & INTENSITY & INTENSITY) when (blank = '0') else X"0";
Green <= (INTENSITY & INTENSITY & INTENSITY & INTENSITY) when (blank = '0') else X"0";
Blue <= (INTENSITY & INTENSITY & INTENSITY & INTENSITY) when (blank = '0') else X"0";


end Behavioral;
