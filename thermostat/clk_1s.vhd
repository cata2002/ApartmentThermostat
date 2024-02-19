----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:03:28 05/19/2022 
-- Design Name: 
-- Module Name:    clk_3s - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_1s is
    Port ( clk : in  STD_LOGIC;
           clk1s : out  STD_LOGIC);
end clk_1s;

architecture Behavioral of clk_1s is
signal divider: std_logic_vector(23 downto 0):="000000000000000000000000";
signal nr:integer:=0;
signal aux:std_logic:='0';
begin
process  (clk)
	begin
		if clk='1' and clk'event then 
			if nr=100000000 then
			nr<=0;
			aux<=not aux;
			else
			nr<=nr+1;
			end if;
		end if;
	end process;	
	clk1s<=aux;
end Behavioral;

