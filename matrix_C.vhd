library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity matrix_C is 
port(clk, wr : in std_logic; 
	addr : in std_logic_vector(3 downto 0); 
	din : in std_logic_vector(17 downto 0);
	dout : out std_logic_vector(17 downto 0));
end matrix_C; 

architecture rtl of matrix_C is

type ram_type is array (0 to 8) of std_logic_vector(17 downto 0); 
--signal program: ram_type; 

signal program : ram_type := (
"000000000000000000",
"000000000000000000",
"000000000000000000",
"000000000000000000", 
"000000000000000000",
"000000000000000000",
"000000000000000000", 
"000000000000000000", 
"000000000000000000"); 

begin

	process(clk) 
	begin 

		if (rising_edge(clk)) then 
			if (wr = '1') then 
				program(conv_integer(unsigned(addr))) <= din;
			end if;
		end if;
	end process;

 	dout <=program(conv_integer(8)) when addr="1001" else program(conv_integer(unsigned(addr)));
end rtl;

