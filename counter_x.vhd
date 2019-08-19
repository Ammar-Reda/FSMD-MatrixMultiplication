library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity counter_x is
	port (clk, rst, en: in std_logic;
		count_out: out std_logic_vector(2 downto 0));
end entity counter_x;

architecture rtl of counter_x is
	signal count_temp: unsigned(2 downto 0);
begin

	process (rst, clk)
	begin
		if (rst = '1') then
			count_temp <= (others =>'0');
		elsif (rising_edge(clk)) then
			if(en='1') then
				count_temp <= count_temp + 3;
			end if;
		end if;
	end process;

	count_out <= std_logic_vector(count_temp);
end architecture rtl;


