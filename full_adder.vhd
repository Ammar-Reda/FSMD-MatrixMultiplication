library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity full_adder is
	port (a, b, cin: in std_logic;
		cout, sum: out std_logic);
end full_adder ;

architecture rtl of full_adder is
begin
	sum <= a xor b xor cin;
	cout <= (a and cin) or (b and cin) or (a and b);
end rtl;
