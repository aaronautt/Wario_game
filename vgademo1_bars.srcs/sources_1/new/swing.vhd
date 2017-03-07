----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2017 10:05:31 AM
-- Design Name: 
-- Module Name: swing - Behavioral
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

entity swing is
  Port (vs, blank : in std_logic;
        hcount, vcount : in STD_LOGIC_VECTOR(10 downto 0);
        Red, Green, Blue : out STD_LOGIC_VECTOR(3 downto 0));
end swing;

architecture Behavioral of swing is

  signal rad : integer := 25; -- radius of the ball
  signal radiusSq : integer := 625;
  constant x_center : integer := 320; --center of the arc that the ball swings
  constant y_center : integer := 100;
  signal x_pos : integer := 320;
  signal y_pos : integer := 380;
  constant arc_rad : integer := 100;
  constant ten_arc : integer := 38;
  signal speed : integer := 5;
  signal increase : STD_LOGIC := '0'; -- flag to set whether the circle is in
                                      -- the top or bottom half '1' is bottom

  type x_int_array is array (0 to 72) of integer;
  constant x_data: x_int_array := (320, 328, 337, 345, 354, 362, 370, 377, 384, 390, 396, 401, 406, 410, 413, 416, 418, 419, 420, 419, 418, 416, 413, 410, 406, 401, 396, 390, 384, 377, 370, 362, 354, 345, 337, 328, 320, 311, 302, 294, 285, 277, 270, 262, 255, 249, 243, 238, 233, 229, 226, 223, 221, 220, 220, 220, 221, 223, 226, 229, 233, 238, 243, 249, 255, 262, 269, 277, 285, 294, 302, 311, 320);
  
   type y_int_array is array (0 to 72) of integer;
  constant y_data: y_int_array := (200, 199, 198, 196, 193, 190, 186, 181, 176, 170, 164, 157, 150, 142, 134, 125, 117, 108, 99, 91, 82, 74, 65, 57, 50, 42, 35, 29, 23, 18, 13, 9, 6, 3, 1, 0, 0, 0, 1, 3, 6, 9, 13, 18, 23, 29, 35, 42, 50, 57, 65, 74, 82, 91, 100, 108, 117, 125, 134, 142, 150, 157, 164, 170, 176, 181, 186, 190, 193, 196, 198, 199, 200);
  

  function  sqrt  ( d : UNSIGNED ) return UNSIGNED;
  function  sqrt  ( d : UNSIGNED ) return UNSIGNED is
    variable a : unsigned(31 downto 0):= d;  --original input.
    variable q : unsigned(15 downto 0):=(others => '0');  --result.
    variable left,right,r : unsigned(17 downto 0):=(others => '0');  --input to adder/sub.r-remainder.
    variable i : integer:=0;
  begin
    for i in 0 to 15 loop
      right(0):='1';
      right(1):=r(17);
      right(17 downto 2):=q;
      left(1 downto 0):=a(31 downto 30);
      left(17 downto 2):=r(15 downto 0);
      a(31 downto 2):=a(29 downto 0);  --shifting by 2 bit.
      if ( r(17) = '1') then
        r := left + right;
      else
        r := left - right;
      end if;
      q(15 downto 1) := q(14 downto 0);
      q(0) := not r(17);
    end loop;
    return q;
  end sqrt;

  begin

    arc_find : process(hcount, vcount, blank, vs)
      variable count : integer := 0;
      variable sync_count : integer := 0;
      variable row : integer := 0;
      variable col : integer := 0;
      variable number : integer := 0;
      variable num : integer := 0;
      variable num1 : integer := 0;
   begin
     if rising_edge(vs) then
       count := count + 1;
       if count = 200 then
         count := 0;
         sync_count := sync_count + 1;
         if sync_count = 73 then
           sync_count := 0;
         end if;
       end if;
     end if;
     x_pos <= x_data(sync_count);
     y_pos <= y_data(sync_count);
     --num := arc_rad*arc_rad-(x_data(sync_count) - x_center)*(x_data(sync_count) - x_center);
     --num1 := TO_INTEGER(sqrt(TO_UNSIGNED(num,32)));
     --number := 100 + num1;
     --y_pos <= number;
   end process;

      
--U1 : port map squart(clock => clk, data_in => data_in, data_out => data_out);

--    vsync : process(hcount, vcount)
--    begin
--      if vcount = "0111100000" and hcount = "1010000000" then
--        vs <= not vs;
--      end if;
--    end process;
    

draw_circle : process(hcount,vcount,blank)       -- Procedural block for displaying the GREEN object
    variable row : integer := 0;
    variable col : integer := 0;
    variable number : integer := 0;
    variable Ecol1, Ecol2, Erow1, Erow2 : integer := 0;
    

  begin
    row := conv_integer(vcount);
    col := conv_integer(hcount);
    Ecol1 := x_pos + TO_INTEGER(sqrt(TO_UNSIGNED((radiusSq-(row-y_pos)*(row-y_pos)),32)));
    Ecol2 := x_pos - TO_INTEGER(sqrt(TO_UNSIGNED((radiusSq-(row-y_pos)*(row-y_pos)),32)));
    Erow1 := y_pos + TO_INTEGER(sqrt(TO_UNSIGNED((radiusSq-(col-x_pos)*(col-x_pos)),32)));
    Erow2 := y_pos - TO_INTEGER(sqrt(TO_UNSIGNED((radiusSq-(col-x_pos)*(col-x_pos)),32)));

    if(col = Ecol1 or row = Erow1 or col = Ecol2 or row = Erow2) and (blank = '0') then
     Green <= X"F";
    else
      Green <= X"0"
               ;
    end if;
  end process;

  --x_arc : process(vs)
  --  variable count, a_count : integer := -1;
  --begin
  --  if vs'event and vs = '1' then
  --   a_count := a_count + 1;
  --   if a_count = 25 then
  --   a_count := 0;
  --    count := count +1;
  --    if count = 72 then count := 0;
  --    end if;
  --    x_pos <= x_data(count);
  --    y_pos <= y_data(count);
  --    --if x_pos >= x_center and y_pos >= y_center then
  --    --  x_pos <= x_pos + speed;
  --    --  increase <= '1';
  --    --elsif x_pos >= x_center and y_pos < y_center then
  --    --  x_pos <= x_pos - speed;
  --    --  increase <= '0';
  --    --elsif x_pos < x_center and y_pos < y_center then
  --    --  x_pos <= x_pos - speed;
  --    --  increase <= '0';
  --    --elsif x_pos < x_center and y_pos >= y_center then
  --    --  x_pos <= x_pos + speed;
  --    --  increase <= '1';
  --    --end if;
  --  end if;
  --  end if;
  --end process;


      --y_arc : process(vs)
      --begin
      --  if x_pos <= (x_center + ten_arc) and x_pos > (x_center - ten_arc)  then 
      --    if x_pos = (x_center + ten_arc) or x_pos = (x_center + (ten_arc/2)) then
      --      y_pos <= y_pos - 1;
      --    elsif x_pos = (x_center - ten_arc) or x_pos = (x_center - ten_arc/2) then
      --      y_pos <= y_pos  + 1;
      --    end if;
      --  elsif x_pos <= (x_center + 2*ten_arc) and x_pos > (x_center + ten_arc)then


--x look ups
--[320, 353, 385, 418, 449, 480, 510, 537, 564, 588, 611, 631, 649, 664, 677, 687, 694, 698, 700, 698, 694, 687, 677, 664, 649, 631, 611, 588, 564, 537, 510, 480, 449, 418, 385, 353, 320, 286, 254, 221, 190, 159, 130, 102, 75, 51, 28, 8, -9, -24, -37, -47, -54, -58, -60, -58, -54, -47, -37, -24, -9, 8, 28, 51, 75, 102, 129, 159, 190, 221, 254, 286, 319]
--y look ups
--[380, 378, 374, 367, 357, 344, 329, 311, 291, 268, 244, 217, 190, 160, 129, 98, 65, 33, 0, -33, -65, -98, -129, -160, -189, -217, -244, -268, -291, -311, -329, -344, -357, -367, -374, -378, -380, -378, -374, -367, -357, -344, -329, -311, -291, -268, -244, -217, -189, -160, -129, -98, -65, -33, 0, 33, 65, 98, 129, 160, 189, 217, 244, 268, 291, 311, 329, 344, 357, 367, 374, 378]
end Behavioral;
