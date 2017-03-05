----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2016 04:30:17 PM
-- Design Name: 
-- Module Name: merge_display - Behavioral
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

entity merge_display is
Port (Red_w,Red_b : in STD_LOGIC_VECTOR(3 downto 0);
      Green_w,Green_b : in STD_LOGIC_VECTOR(3 downto 0);
      Blue_w,Blue_b : in STD_LOGIC_VECTOR(3 downto 0);
      RED, GREEN, BLUE : out STD_LOGIC_VECTOR(3 downto 0));
end merge_display;

architecture Behavioral of merge_display is
begin
 RED(3) <= Red_w(3) when (Red_w & Green_w & Blue_w /= "000000000000") else Red_b(3); --or Red_c(3) or Red_d(3) or Red_e(3);
 RED(2) <= Red_w(2) when (Red_w & Green_w & Blue_w /= "000000000000") else Red_b(2); --or Red_c(2) or Red_d(2) or Red_e(2);
 RED(1) <= Red_w(1) when (Red_w & Green_w & Blue_w /= "000000000000") else Red_b(1); --or Red_c(1) or Red_d(1) or Red_e(1);
 RED(0) <= Red_w(0) when (Red_w & Green_w & Blue_w /= "000000000000") else Red_b(0); --or Red_c(0) or Red_d(0) or Red_e(0);
 
 GREEN(3) <= Green_w(3) when (Red_w & Green_w & Blue_w /= "000000000000") else Green_b(3); --or Green_c(3) or Green_d(3) or Green_e(3);
 GREEN(2) <= Green_w(2) when (Red_w & Green_w & Blue_w /= "000000000000") else Green_b(2); --or Green_c(2) or Green_d(2) or Green_e(2);
 GREEN(1) <= Green_w(1) when (Red_w & Green_w & Blue_w /= "000000000000") else Green_b(1); --or Green_c(1) or Green_d(1) or Green_e(1);
 GREEN(0) <= Green_w(0) when (Red_w & Green_w & Blue_w /= "000000000000") else Green_b(0); --or Green_c(0) or Green_d(0) or Green_e(0);
 
 BLUE(3) <= Blue_w(3) when (Red_w & Green_w & Blue_w /= "000000000000") else Blue_b(3); --or Blue_c(3) or Blue_d(3) or Blue_e(3);
 BLUE(2) <= Blue_w(2) when (Red_w & Green_w & Blue_w /= "000000000000") else Blue_b(2); --or Blue_c(2) or Blue_d(2) or Blue_e(2);
 BLUE(1) <= Blue_w(1) when (Red_w & Green_w & Blue_w /= "000000000000") else Blue_b(1); --or Blue_c(1) or Blue_d(1) or Blue_e(1);
 BLUE(0) <= Blue_w(0) when (Red_w & Green_w & Blue_w /= "000000000000") else Blue_b(0); --or Blue_c(0) or Blue_d(0) or Blue_e(0);

end Behavioral;
