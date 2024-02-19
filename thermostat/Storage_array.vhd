----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:45:34 05/23/2022 
-- Design Name: 
-- Module Name:    Storage_array - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Storage_array is
port( clk: in std_logic;
n0,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15,n16,n17,n18,n19,n20,n21,n22,n23: in integer;
o0,o1,o2,o3,o4,o5,o6,o7,o8,o9,o10,o11,o12,o13,o14,o15,o16,o17,o18,o19,o20,o21,o22,o23:out integer);
end Storage_array;

architecture Behavioral of Storage_array is

begin
process(clk)
begin
	if rising_edge(clk) then
	o0<=n0;o1<=n1;o2<=n2;o3<=n3;o4<=n4;o5<=n5;o6<=n6;o7<=n7;o8<=n8;o9<=n9;o10<=n10;o11<=n11;o12<=n12;o13<=n13;o14<=n14;o15<=n15;o16<=n16;o17<=n17;o18<=n18;o19<=n19;o20<=n20;o21<=n21;o22<=n22;o23<=n23;
	end if;
end process;
end Behavioral;

