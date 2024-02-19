library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity mod_test is 
    Port ( clk : in  STD_LOGIC;
           rst: in std_logic;	 
           dir : in  STD_LOGIC_vector(2 downto 0);
			  set_min_max : in  STD_LOGIC_vector(3 downto 0); --left bit to activate, second set max, third set min, fourth confirm
           set_specific: in std_logic_vector(4 downto 0);
			  outp1 : out  STD_LOGIC_vector(3 downto 0);
			  outp2: out std_logic_vector(3 downto 0);
			  led_rst: out std_logic:='0';
			  led_heat: out std_logic:='0');
end mod_test;

architecture behav of mod_test is
component clk_3s is
    Port ( clk : in  STD_LOGIC;
           clk3s : out  STD_LOGIC);
end component clk_3s;
component bounce is
	 port(
		 btn : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 btn_ok : out STD_LOGIC
	     );
end component bounce;
component Storage_array is
port( clk: in std_logic;
n0,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15,n16,n17,n18,n19,n20,n21,n22,n23: in integer;
o0,o1,o2,o3,o4,o5,o6,o7,o8,o9,o10,o11,o12,o13,o14,o15,o16,o17,o18,o19,o20,o21,o22,o23:out integer);
end component Storage_array;
shared variable cif1,cif2,aux1,aux2,aux3,aux4,minim,maxim,ora:integer:=0;
signal clk3,rst1:std_logic;
type int_memory is array (0 to 23) of integer;
signal m1,m2:int_memory:=(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
shared variable max_sir,min_sir:int_memory:=(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
begin
	clock: clk_3s port map(clk,clk3);
	buton: bounce port map(rst,clk,rst1);
	process(clk3,rst1,dir,set_min_max,set_specific)
	begin
		case dir is
		when "000" =>cif1:=0;cif2:=0;
		when "100" =>cif1:=2;cif2:=1;
		when "110" =>
		if rising_edge(clk3) then
			cif2:=cif2-1;
			if cif2=-1 then
			cif1:=cif1-1;
			cif2:=9;
			end if;
			end if;
		when "101" =>
		if rising_edge(clk3) then
			cif2:=cif2+1;
			if cif2=10 then
			cif1:=cif1+1;
			cif2:=0;
			end if;
			end if;
		when others=> cif1:=0;cif2:=0;
		end case;
		case set_min_max is
			when "0000"=> aux1:=0;aux2:=0;
			when "1000"=> aux1:=1;aux2:=8;
			when "1100"=>
			if rising_edge(clk3) then
				aux2:=aux2-1;
				if aux2=-1 then
				aux1:=aux1-1;
				aux2:=9;
				end if;
				end if;
			when "1101"=> minim:=aux1*10+aux2;aux1:=aux1;aux2:=aux2;
			when "1010"=>
			if rising_edge(clk3) then
				aux2:=aux2+1;
				if aux2=10 then
				aux1:=aux1+1;
				aux2:=0;
				end if;
				end if;
			when "1011" =>maxim :=aux1*10+aux2;aux1:=aux1;aux2:=aux2;
			when others=> aux1:=0;aux2:=0;
			end case;
			if dir="000" then cif1:=aux1;cif2:=aux2;end if;
		case set_specific is
			when "00000"=> aux3:=0;aux4:=0;
			when "10000"=>
				if rising_edge(clk3) then
				aux4:=aux4+1;
				if aux4=10 then
				aux4:=0;
				aux3:=aux3+1;
				if aux3=2 and aux4=5 then aux3:=0;aux4:=0;end if;end if;end if;
			when "11000"=> ora:=aux4*10+aux3;aux3:=0;aux4:=0;
			when "01100"=>--aux3:=1;aux4:=8;
			if rising_edge(clk3) then
			aux4:=aux4+1;
			if aux4=10 then
			aux4:=0;
			aux3:=aux3+1;end if;end if;
			when "01101"=>min_sir(ora):=aux3*10+aux4;aux3:=aux3;aux4:=aux4;
			when "01010"=>--aux3:=1;aux4:=6;
			if rising_edge(clk3) then
			aux4:=aux4+1;
			if aux4=10 then
			aux4:=0;aux3:=aux3+1;end if;end if;
			when "01011"=>max_sir(ora):=aux3*10+aux4;aux3:=aux3;aux4:=aux4;
			when others=> aux3:=0;aux4:=0;
			end case;
			if dir="000" and set_min_max="0000" then cif1:=aux3;cif2:=aux4;end if;
			if set_min_max(0)='1' or set_specific(0)='1' then led_heat<='1';else led_heat<='0';end if;
			if rst1='1' then led_rst<='1';minim:=0;maxim:=0;cif1:=5;cif2:=0;else led_rst<='0';end if;
		case cif1 is 
			when 0=>outp1<="0000";
			when 1=>outp1<="0001"; 
			when 2=>outp1<="0010";
			when 3=>outp1<="0011";
			when 4=>outp1<="0100";
			when 5=>outp1<="0101";
			when 6=>outp1<="0110";
			when 7=>outp1<="0111";
			when 8=>outp1<="1000";
			when 9=>outp1<="1001";
			when others=>outp1<="0000";
			end case;
			case cif2 is 
			when 0=>outp2<="0000";
			when 1=>outp2<="0001";
			when 2=>outp2<="0010";
			when 3=>outp2<="0011";
			when 4=>outp2<="0100";
			when 5=>outp2<="0101";
			when 6=>outp2<="0110";
			when 7=>outp2<="0111";
			when 8=>outp2<="1000";
			when 9=>outp2<="1001";
			when others=>outp2<="0000";
			end case;
	end process;
	c1: storage_array port map (clk,min_sir(0),min_sir(1),min_sir(2),min_sir(3),min_sir(4),min_sir(5),min_sir(6),min_sir(7),min_sir(8),min_sir(9),min_sir(10),min_sir(11),min_sir(12),min_sir(13),min_sir(14),min_sir(15),min_sir(16),min_sir(17),min_sir(18),min_sir(19),min_sir(20),min_sir(21),min_sir(22),min_sir(23),m1(0),m1(1),m1(2),m1(3),m1(4),m1(5),m1(6),m1(7),m1(8),m1(9),m1(10),m1(11),m1(12),m1(13),m1(14),m1(15),m1(16),m1(17),m1(18),m1(19),m1(20),m1(21),m1(22),m1(23));
	c2: storage_array port map (clk,max_sir(0),max_sir(1),max_sir(2),max_sir(3),max_sir(4),max_sir(5),max_sir(6),max_sir(7),max_sir(8),max_sir(9),max_sir(10),max_sir(11),max_sir(12),max_sir(13),max_sir(14),max_sir(15),max_sir(16),max_sir(17),max_sir(18),max_sir(19),max_sir(20),max_sir(21),max_sir(22),max_sir(23),m2(0),m2(1),m2(2),m2(3),m2(4),m2(5),m2(6),m2(7),m2(8),m2(9),m2(10),m2(11),m2(12),m2(13),m2(14),m2(15),m2(16),m2(17),m2(18),m2(19),m2(20),m2(21),m2(22),m2(23));
end architecture;