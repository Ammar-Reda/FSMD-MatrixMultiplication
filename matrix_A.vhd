library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity matrix_A is 
	port(addr: in std_logic_vector (3 downto 0); data: out std_logic_vector (7 downto 0)); 
end matrix_A; 

architecture rtl of matrix_A is 
	type rom_type is array (0 to 8) of std_logic_vector (7 downto 0); 
constant program : rom_type := (
"01111111",
"10000000",
"11110000",
"11000011", 
"11101110",
"10011111",
"11111110", 
"11110101", 
"10010000"); 

begin
	process(addr)
	begin

		if((unsigned(addr)>= 8)) then 
			data <= program(conv_integer(8));
		else 
			data <= program(conv_integer(unsigned(addr)));
		end if;
	end process;
end rtl;

