library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity ram_b is 
port(clk, wr : in std_logic; 
	data_in_addr : in std_logic_vector(3 downto 0);
	addr : in std_logic_vector(3 downto 0); 
	din : in std_logic_vector(7 downto 0);
	dout : out std_logic_vector(7 downto 0));
end ram_b; 

architecture rtl of ram_b is

type ram_type is array (0 to 8) of std_logic_vector(7 downto 0); 


signal program : ram_type := (
"00000000",
"00000000",
"00000000",
"00000000", 
"00000000",
"00000000",
"00000000", 
"00000000", 
"00000000"); 

begin

	process(clk) 
	begin 

		if (rising_edge(clk)) then 
			if (wr = '1') then 
				program(conv_integer(unsigned(data_in_addr))) <= din;
			end if;
		end if;
	end process;

	dout <=program(conv_integer(8)) when (unsigned(addr)>= 8) else program(conv_integer(unsigned(addr)));
end rtl;


