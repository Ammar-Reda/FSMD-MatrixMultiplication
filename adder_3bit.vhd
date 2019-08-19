library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity adder_3bit is
	port(a ,b : in std_logic_vector (2 downto 0);
		sum : out std_logic_vector (3 downto 0));
end adder_3bit;


architecture rtl of adder_3bit is

component full_adder is
	port (a, b, cin: in std_logic;
		cout, sum: out std_logic);
end component;	

	signal c: std_logic_vector (1 downto 0);
	signal s_int: std_logic_vector (2 downto 0);
	signal cout: std_logic;

begin 

inst_0: full_adder port map (a(0), b(0), '0', c(0), s_int(0));
inst_1: full_adder port map (a(1), b(1), c(0), c(1), s_int(1));
inst_2: full_adder port map (a(2), b(2), c(1), cout, s_int(2));


sum <= cout&s_int;
	
end architecture rtl;
