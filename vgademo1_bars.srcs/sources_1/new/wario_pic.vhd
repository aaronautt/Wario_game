----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/31/2014 02:19:44 PM
-- Design Name: 
-- Module Name: MY_PIXEL_DRIVER - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MY_PIXEL_DRIVER is
Port (clk25 : in STD_LOGIC; hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); 
      blank : in STD_LOGIC;
      pic_on : out STD_LOGIC;
      Red, Green, Blue : out STD_LOGIC_VECTOR(3 downto 0));
end MY_PIXEL_DRIVER;

architecture Behavioral of MY_PIXEL_DRIVER is

-- Screen dimensions
    constant ROW_MAX : STD_LOGIC_VECTOR (10 downto 0) := "00111100000"; --480
    constant COL_MAX : STD_LOGIC_VECTOR (10 downto 0) := "01010000000"; --640

-- Center screen coordinates
    constant ROW_CENTER : STD_LOGIC_VECTOR (10 downto 0) := "00101110100";
    constant COL_CENTER : STD_LOGIC_VECTOR (10 downto 0) := "00100001110"; --269

-- Image dimensions
    constant WIDTH : integer := 62;
    constant HEIGHT : integer := 65;    
    constant CROP : integer := 1; -- Remove outer pixel layers

-- Image coordinates
    signal myrow : STD_LOGIC_VECTOR (10 downto 0) := ROW_CENTER;
    signal mycol : STD_LOGIC_VECTOR (10 downto 0) := COL_CENTER;

-- Wario ROM Component
COMPONENT blk_mem_gen_1
  PORT (clka : IN STD_LOGIC; addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0));
END COMPONENT;

signal rom_address : STD_LOGIC_VECTOR(11 downto 0);
signal rom_data : STD_LOGIC_VECTOR(11 downto 0);

signal rom_row : STD_LOGIC_VECTOR(21 downto 0);
signal rom_col : STD_LOGIC_VECTOR(10 downto 0);

signal display_flag : STD_LOGIC;



begin
pic_on <= display_flag;
W1 : blk_mem_gen_1 port map(clka => clk25, addra => rom_address, douta => rom_data);

-- Generate ROM address
rom_row <= std_logic_vector(unsigned(vcount - myrow) * WIDTH);
rom_col <= hcount - mycol;
rom_address <= rom_col + rom_row(11 downto 0);

display_flag <= '1' when blank = '0' and --inside screen
                         rom_data /= X"F00" and --remove background (must be a unique color)
                         ((vcount - myrow + CROP) < HEIGHT) and --height
                         ((myrow - vcount + CROP) > HEIGHT) and
                         ((hcount - mycol + CROP) < WIDTH) and --width
                         ((mycol - hcount + CROP) > WIDTH)
                    else '0';


Red(3) <= rom_data(11) when display_flag = '1' else '0';
Red(2) <= rom_data(10) when display_flag = '1' else '0';
Red(1) <= rom_data(9) when display_flag = '1' else '0';
Red(0) <= rom_data(8) when display_flag = '1' else '0';

Green(3) <= rom_data(7) when display_flag = '1' else '0';
Green(2) <= rom_data(6) when display_flag = '1' else '0';
Green(1) <= rom_data(5) when display_flag = '1' else '0';
Green(0) <= rom_data(4) when display_flag = '1' else '0';

Blue(3) <= rom_data(3) when display_flag = '1' else '0';
Blue(2) <= rom_data(2) when display_flag = '1' else '0';
Blue(1) <= rom_data(1) when display_flag = '1' else '0';
Blue(0) <= rom_data(0) when display_flag = '1' else '0';

end Behavioral;
