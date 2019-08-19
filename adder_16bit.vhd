library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity adder_16bit is
	port(a,b : in std_logic_vector (15 downto 0);
		sum : out std_logic_vector (15 downto 0);
		cout: out std_logic);
end adder_16bit;


architecture rtl of adder_16bit is

component full_adder is
	port (a, b, cin: in std_logic;
		cout, sum: out std_logic);
end component;	

	signal c: std_logic_vector (14 downto 0);
	signal s_int: std_logic_vector (15 downto 0);

begin 

inst_0: full_adder port map (a(0), b(0), '0', c(0), s_int(0));
inst_1: full_adder port map (a(1), b(1), c(0), c(1), s_int(1));
inst_2: full_adder port map (a(2), b(2), c(1), c(2), s_int(2));
inst_3: full_adder port map (a(3), b(3), c(2), c(3), s_int(3));
inst_4: full_adder port map (a(4), b(4), c(3), c(4), s_int(4));
inst_5: full_adder port map (a(5), b(5), c(4), c(5), s_int(5));
inst_6: full_adder port map (a(6), b(6), c(5), c(6), s_int(6));
inst_7: full_adder port map (a(7), b(7), c(6), c(7), s_int(7));
inst_8: full_adder port map (a(8), b(8), c(7), c(8), s_int(8));
inst_9: full_adder port map (a(9), b(9), c(8), c(9), s_int(9));
inst_10: full_adder port map (a(10), b(10), c(9), c(10), s_int(10));
inst_11: full_adder port map (a(11), b(11), c(10), c(11), s_int(11));
inst_12: full_adder port map (a(12), b(12), c(11), c(12), s_int(12));
inst_13: full_adder port map (a(13), b(13), c(12), c(13), s_int(13));
inst_14: full_adder port map (a(14), b(14), c(13), c(14), s_int(14));
inst_15: full_adder port map (a(15), b(15), c(14), cout, s_int(15));


sum <= s_int;
	
end architecture rtl;
