library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity mul is
	port(clk ,rst ,start: in std_logic; xin, yin : in std_logic_vector (7 downto 0);
		result: out std_logic_vector (15 downto 0); cout, done: out std_logic);
end mul;


architecture rtl of mul is

component reg_16bit_shf is

	port (clk, rst, wr, shift_left: in std_logic;
		reg_in: in std_logic_vector(7 downto 0);
		reg_out: out std_logic_vector(15 downto 0));

end component;

component reg_8bit is

	port (clk, rst, wr, shift_right: in std_logic;
		reg_in: in std_logic_vector(7 downto 0);
		reg_out: out std_logic_vector(7 downto 0));

end component;

component reg_16bit is
	port (clk, rst, en: in std_logic;
		reg_in: in std_logic_vector(15 downto 0);
		reg_out: out std_logic_vector(15 downto 0));
end component;

component adder_16bit is
	port(a ,b : in std_logic_vector (15 downto 0);
		sum : out std_logic_vector (15 downto 0);
		cout: out std_logic);
end component;

component mul_fsm is

	port (clk, rst, start, fin, mul : in std_logic;
		shr ,shl ,wr, wrm, clr, count_en, sdone: out std_logic);
end component;

component counter is
	port (clk, rst, en: in std_logic;
		fin: out std_logic);
end component;


signal clr_int, shl_int, shr_int, wr_int, wrm_int, counter_fin, counter_en, sdone_int: std_logic;
signal multiplicand_out, adder_out, product_out: std_logic_vector(15 downto 0);
signal multiplier_out: std_logic_vector(7 downto 0);

begin 
	
	multiplicand: reg_16bit_shf port map(clk, clr_int, wrm_int, shl_int, xin, multiplicand_out);
	
	multiplier: reg_8bit port map (clk, clr_int, wrm_int, shr_int, yin, multiplier_out); 
	product: reg_16bit port map (clk, clr_int, wr_int, adder_out, product_out);

	adder: adder_16bit port map (multiplicand_out, product_out, adder_out, cout);

	aaaa: mul_fsm port map (clk, rst, start, counter_fin, multiplier_out(0), shr_int, shl_int, wr_int, 
				wrm_int, clr_int, counter_en, sdone_int);
	c: counter port map(clk, clr_int, counter_en, counter_fin);


        result <= product_out;

	--done <= counter_fin;
	done <= sdone_int;
end architecture rtl;
