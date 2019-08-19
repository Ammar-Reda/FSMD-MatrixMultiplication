library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity counter is
	port (clk, rst, en: in std_logic;
		fin: out std_logic);
end entity counter;

architecture rtl of counter is
	signal count_temp: unsigned(3 downto 0);
begin

	process (rst, clk)
	begin
		if (rst = '1') then
			count_temp <= (others =>'0');
		elsif (rising_edge(clk)) then
			if(en='1') then
				count_temp <= count_temp + 1;
			end if;
		end if;
	end process;

	fin <= '1' when count_temp =8 else '0';
end architecture rtl;
