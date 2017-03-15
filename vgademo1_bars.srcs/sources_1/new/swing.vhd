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
  Port (vs, blank, clk, btn : in std_logic;
        LED : out std_logic;
        punch : inout integer;
        hcount, vcount : in STD_LOGIC_VECTOR(10 downto 0);
        Red, Green, Blue : out STD_LOGIC_VECTOR(3 downto 0));
        --collide : out STD_LOGIC_VECTOR (1 downto 0));
end swing;

architecture Behavioral of swing is

  
 

  type x_int_array is array (0 to 360) of integer;
  signal x_data : x_int_array := (320, 322, 325, 327, 330, 333, 335, 338, 340, 343,
                                  346, 348, 351, 353, 356, 358, 361, 363, 366, 368,
                                  371, 373, 376, 378, 381, 383, 385, 388, 390, 392,
                                  395, 397, 399, 401, 403, 406, 408, 410, 412, 414,
                                  416, 418, 420, 422, 424, 426, 427, 429, 431, 433,
                                  434, 436, 438, 439, 441, 442, 444, 445, 447, 448,
                                  449, 451, 452, 453, 454, 455, 457, 458, 459, 460,
                                  460, 461, 462, 463, 464, 464, 465, 466, 466, 467,
                                  467, 468, 468, 468, 469, 469, 469, 469, 469, 469,
                                  470, 469, 469, 469, 469, 469, 469, 468, 468, 468,
                                  467, 467, 466, 466, 465, 464, 464, 463, 462, 461,
                                  460, 460, 459, 458, 457, 455, 454, 453, 452, 451,
                                  449, 448, 447, 445, 444, 442, 441, 439, 438, 436,
                                  434, 433, 431, 429, 427, 426, 424, 422, 420, 418,
                                  416, 414, 412, 410, 408, 406, 403, 401, 399, 397,
                                  395, 392, 390, 388, 385, 383, 381, 378, 376, 373,
                                  371, 368, 366, 363, 361, 358, 356, 353, 351, 348,
                                  346, 343, 340, 338, 335, 333, 330, 327, 325, 322,
                                  320, 317, 314, 312, 309, 306, 304, 301, 299, 296,
                                  293, 291, 288, 286, 283, 281, 278, 276, 273, 271,
                                  268, 266, 263, 261, 258, 256, 254, 251, 249, 247,
                                  245, 242, 240, 238, 236, 233, 231, 229, 227, 225,
                                  223, 221, 219, 217, 215, 213, 212, 210, 208, 206,
                                  205, 203, 201, 200, 198, 197, 195, 194, 192, 191,
                                  190, 188, 187, 186, 185, 184, 182, 181, 180, 179,
                                  179, 178, 177, 176, 175, 175, 174, 173, 173, 172,
                                  172, 171, 171, 171, 170, 170, 170, 170, 170, 170,
                                  170, 170, 170, 170, 170, 170, 170, 171, 171, 171,
                                  172, 172, 173, 173, 174, 175, 175, 176, 177, 178,
                                  179, 179, 180, 181, 182, 184, 185, 186, 187, 188,
                                  190, 191, 192, 194, 195, 197, 198, 200, 201, 203,
                                  205, 206, 208, 210, 212, 213, 215, 217, 219, 221,
                                  223, 225, 227, 229, 231, 233, 236, 238, 240, 242,
                                  244, 247, 249, 251, 254, 256, 258, 261, 263, 266,
                                  268, 271, 273, 276, 278, 281, 283, 286, 288, 291,
                                  293, 296, 299, 301, 304, 306, 309, 312, 314, 317, 320);
  
  type y_int_array is array (0 to 360) of integer;
  signal y_data : y_int_array := (400, 399, 399, 399, 399, 399, 399, 398, 398, 398,
                                  397, 397, 396, 396, 395, 394, 394, 393, 392, 391,
                                  390, 390, 389, 388, 387, 385, 384, 383, 382, 381,
                                  379, 378, 377, 375, 374, 372, 371, 369, 368, 366,
                                  364, 363, 361, 359, 357, 356, 354, 352, 350, 348, 346, 344, 342, 340, 338, 336, 333, 331, 329, 327, 325, 322, 320, 318, 315, 313, 311, 308, 306, 303, 301, 298, 296, 293, 291, 288, 286, 283, 281, 278, 276, 273, 270, 268, 265, 263, 260, 257, 255, 252, 249, 247, 244, 242, 239, 236, 234, 231, 229, 226, 223, 221, 218, 216, 213, 211, 208, 206, 203, 201, 198, 196, 193, 191, 188, 186, 184, 181, 179, 177, 175, 172, 170, 168, 166, 163, 161, 159, 157, 155, 153, 151, 149, 147, 145, 143, 142, 140, 138, 136, 135, 133, 131, 130, 128, 127, 125, 124, 122, 121, 120, 118, 117, 116, 115, 114, 112, 111, 110, 109, 109, 108, 107, 106, 105, 105, 104, 103, 103, 102, 102, 101, 101, 101, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 101, 101, 101, 102, 102, 103, 103, 104, 105, 105, 106, 107, 108, 109, 109, 110, 111, 112, 114, 115, 116, 117, 118, 120, 121, 122, 124, 125, 127, 128, 130, 131, 133, 135, 136, 138, 140, 142, 143, 145, 147, 149, 151, 153, 155, 157, 159, 161, 163, 166, 168, 170, 172, 175, 177, 179, 181, 184, 186, 188, 191, 193, 196, 198, 201, 203, 206, 208, 211, 213, 216, 218, 221, 223, 226, 229, 231, 234, 236, 239, 242, 244, 247, 250, 252, 255, 257, 260, 263, 265, 268, 270, 273, 276, 278, 281, 283, 286, 288, 291, 293, 296, 298, 301, 303, 306, 308, 311, 313, 315, 318, 320, 322, 325, 327, 329, 331, 333, 336, 338, 340, 342, 344, 346, 348, 350, 352, 354, 356, 357, 359, 361, 363, 364, 366, 368, 369, 371, 372, 374, 375, 377, 378, 379, 381, 382, 383, 384, 385, 387, 388, 389, 390, 390, 391, 392, 393, 394, 394, 395, 396, 396, 397, 397, 398, 398, 398, 399, 399, 399, 399, 399, 399, 400);


  

  -- square root function written by VHDL guru, found at
  -- http://vhdlguru.blogspot.com/2010/03/vhdl-function-for-finding-square-root.html

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

  component debouncer is
    port(clk : in std_logic;
         btn_in : in std_logic;
         btn_out, btn_stop : out std_logic);
  end component;

  component Wario_logic is
    Port (btn_stop, clk : in STD_LOGIC;
          punch, angle : inout integer;
          collide : in STD_LOGIC_VECTOR (1 downto 0));
    end component;


  signal rad_sqr : integer := 400; --radius fo 20 squared
  signal rad : integer := 20;
  signal fist : integer := 330;
  signal x_pos : integer := 150;
  signal y_pos : integer := 100;
  signal speed : integer := 1; --speed variable, higher is slower
  signal increase : STD_LOGIC := '1'; -- flag to set whether the circle is
  -- moving CCW=1 or CW=0
  signal count : integer := 0;
  --signal punch : integer := 3;-- counting which punch it's on punch 1 = 3, then
  -- down from there punch 3 = 1
  signal sync_count : integer := 0;                                    
  signal shift_count : integer := 0;
  signal RGB : STD_LOGIC_VECTOR (11 downto 0) := "000000000000";
  signal collide : STD_LOGIC_VECTOR(1 downto 0) := "00";
  signal btn_out, btn_stop : STD_LOGIC := '0';
  signal angle : integer;

begin

  D1 : debouncer port map (clk => clk, btn_in => btn, btn_out => btn_out, btn_stop => btn_stop);
  L1 : Wario_logic port map (clk => clk, btn_stop => btn_stop, punch => punch, angle => angle,
                             collide => collide);

  process(btn_stop)
  begin
    if btn_stop ='1' then
      LED <= '1';
    else LED <= '0';
    end if;
  end process;


  -- This block defines when a collision event happens and when the arc ends
  -- and reverses for each punch strength



  collision : process(clk, collide, punch, angle)
  begin
    if rising_edge(clk) then
      if y_pos > 350 and increase = '0' and x_pos <= 324 and x_pos > 320 and btn_out = '1' then
        collide <= "01";--If the button is high in the collision zone it moves
                        --on
        increase <= '1';
      elsif y_pos > 350 and increase = '0' and x_pos = 320 and btn_out = '0' then
        collide <= "10";
        increase <= '1';  
      else
        collide <= "00";
      end if;

      if punch > 0 and punch < 9 then
        if sync_count = angle then
          increase <= '0';
        end if;
      end if;


      -- this section defines how far up the ball moves based on which punch
      -- if punch = 3 then -- first punch
      --   if sync_count = angle then
      --     increase <= '0';
      --   end if;
      -- elsif punch = 2 then -- second punch
      --   if sync_count = angle then
      --     increase <= '0';
      --   end if;
      -- elsif punch = 1 then -- third punch
      --   if sync_count = angle then
      --     increase <= '0';
      --   end if;
      -- elsif punch = 5 then
      --   if sync_count = angle then
      --     increase <= '0';
      --     end if;
        --elsif punch = 0 then -- final punch, which will end in an explosion or
                             -- something eventually
        
      end if;
    end if;
  end process;

-- This process just increments the punch that it's on if a collision occurs

  

  -- this block should set the speed change of the ball as it swings
  -- The count will increase slightly each sync_count, and the punch
  -- multiplication will increase the speed as the punches continue
  -- as the count increases it slows down the speed of the ball


  arc_find : process(hcount, vcount, blank, vs, increase, collide, x_pos, y_pos, clk)
  begin
    if rising_edge(clk) then
      count <= count + 1;
      if count = 100000+(punch*50000)+(sync_count*5000) then 
        count <= 0;
        x_pos <= x_data(sync_count);
        y_pos <= y_data(sync_count);
        if increase = '1' then
          sync_count <= sync_count + 1;
        elsif increase = '0' then
          sync_count <= sync_count - 1;
        end if;

        if sync_count = 360 then
          sync_count <= 0;
        end if;
      end if;
    end if;
  end process;


  --this block draws the circle base on the center position calculated above,
  --it then uses the square root function to 

  draw_circle : process(hcount,vcount,blank, clk, collide)       -- Procedural block for displaying the GREEN object
    variable row : integer := 0;
    variable col : integer := 0;
    variable Col_1, Col_2, Row_1, Row_2 : integer := 0;

  begin
    if rising_edge(clk) then
      row := conv_integer(vcount);
      col := conv_integer(hcount);
      
      Col_1 := x_pos + TO_INTEGER(sqrt(TO_UNSIGNED((rad_sqr-(row-y_pos)*(row-y_pos)),32)));
      Col_2 := x_pos - TO_INTEGER(sqrt(TO_UNSIGNED((rad_sqr-(row-y_pos)*(row-y_pos)),32)));
      Row_1 := y_pos + TO_INTEGER(sqrt(TO_UNSIGNED((rad_sqr-(col-x_pos)*(col-x_pos)),32)));
      Row_2 := y_pos - TO_INTEGER(sqrt(TO_UNSIGNED((rad_sqr-(col-x_pos)*(col-x_pos)),32)));
     

      if(col <= Col_1 and col >= Col_2 and row <= Row_1 and row >= Row_2
         and Col_1 > Col_2 and Row_1 > Row_2 and Col_1 >= -50 and Col_1 <= 690
         and Col_2 >= -50 and Col_2 <= 690 and Row_1 >= -50 and Row_1 <= 530
         and Row_2 >= -50 and Row_2 <= 530) and (blank = '0') then
        if collide = "00" then
          Green <= X"1";--RGB(11) & RGB(8) & RGB(5) & RGB(2);
          Blue <= X"2";--RGB(10) & RGB(7) & RGB(4) & RGB(1);
          Red <= X"F";--RGB(9) & RGB(6) & RGB(3) & RGB(0);
        elsif collide = "01" then
          Green <= X"1";
          Blue <= X"0";
          Red <= X"0";
        end if;

      else
        Green <= X"0";
        Blue <= X"0";
        Red <= X"0";         
      end if;
    end if;
  end process;

  -- This block adds color shifting to the ball

  color_shift : process(vs)
    variable up : STD_LOGIC := '0';
  begin
    if rising_edge(vs) then
      shift_count <= shift_count + 1;
      if shift_count = 50 then
        shift_count <= 0;
        if up = '0' then
          RGB <= RGB + 1;
        elsif up = '1' then
          RGB <= RGB - 1;
        end if;
        if RGB = "111111111111" then
          up := '1';
        elsif RGB = "000000101001" then
          up := '0';
        end if;
      end if;
    end if;
  end process;

end Behavioral;
