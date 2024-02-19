----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:09:21 05/21/2022 
-- Design Name: 
-- Module Name:    global_set - Behavioral 
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

entity global_set is
    Port ( clk : in  STD_LOGIC;
           set_min_max : in  STD_LOGIC;
			  set_min: in STD_LOGIC;
			  set_max: in STD_LOGIC;
			  confirm: in std_logic;
           outp1 : out  STD_LOGIC_vector(3 downto 0);
           outp2 : out  STD_LOGIC_vector(3 downto 0));
end global_set;

architecture Behavioral of global_set is
component clk_3s is
    Port ( clk : in  STD_LOGIC;
           clk3s : out  STD_LOGIC);
end component clk_3s;
shared variable minim,maxim:natural:=0;
signal clk_ok:std_logic;
begin
	c1: clk_3s port map(clk,clk_ok);
	process(clk_ok,set_min_max,set_min,set_max)
	variable num1:natural:=1;
	variable num2:natural:=6;
	begin
	--if set_min_max='0' then num1:=1;num2:=6;
	if rising_edge(clk_ok) and set_min_max='1' and set_min='1' and set_max='0' and confirm='0' then 
			num2:=num2-1;
			if num2=0 then num2:=9;num1:=num1-1; end if;
	elsif rising_edge(clk_ok)and set_min_max='1' and set_min='1' and set_max='0' and confirm='1' then
			minim:=num2+10*num1;num1:=0;num2:=0;
	elsif rising_edge(clk_ok) and set_min_max='1' and set_min='0' and set_max='1' and confirm='0' then
			num2:=num2+1;
			if num2=10 then num1:=num1+1;num2:=0;end if;
	elsif rising_edge(clk_ok) and set_min_max='1' and set_min='0' and set_max='1' and confirm='1' then
			maxim:=num2*10+num1;num1:=0;num2:=0;
	else num1:=0;num2:=0;
			end if;
	
	case num1 is
		when 0=> outp1<="0000";
		when 1=> outp1<="0001";
		when 2=> outp1<="0010";
		when 3=> outp1<="0011";
		when others => outp1<="0100";
	end case;
	
	case num2 is 
		when 0=> outp2<="0000";
		when 1=> outp2<="0001";
		when 2=> outp2<="0010";
		when 3=> outp2<="0011";
		when 4=> outp2<="0100";
		when 5=> outp2<="0101";
		when 6=> outp2<="0110";
		when 7=> outp2<="0111";
		when 8=> outp2<="1000";
		when 9=> outp2<="1001";
		when others=> outp2<="0000";
		end case;
	end process;
		

end Behavioral;

