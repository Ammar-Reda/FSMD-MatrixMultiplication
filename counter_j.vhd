library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity counter_j is
	port (clk, rst, clr, en: in std_logic;
		fin: out std_logic;
		count_out: out std_logic_vector(2 downto 0));
end entity counter_j;

architecture rtl of counter_j is
	signal count_temp: unsigned(3 downto 0);
begin

	process (rst, clk)
	begin
		if ((rst or clr) = '1') then
			count_temp <= (others =>'0');
		elsif (rising_edge(clk)) then
			if(en='1') then
				count_temp <= count_temp + 3;
			end if;
		end if;
	end process;
	
	count_out <= std_logic_vector(count_temp(2 downto 0));
	fin <= '1' when count_temp =9 else '0';
end architecture rtl;
