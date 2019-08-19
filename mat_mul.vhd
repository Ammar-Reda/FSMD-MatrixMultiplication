library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity mat_mul is
	--port(clk ,rst ,start: in std_logic; done: out std_logic);		-- in case we use ROMs for matrix A, B
	
	  port(clk ,rst ,start, mat_a_wr, mat_b_wr: in std_logic;  		-- in case we use RAMs for matrix A, B
		a_addr, b_addr: in std_logic_vector(3 downto 0);
		mat_a_in, mat_b_in: in std_logic_vector(7 downto 0);
		done: out std_logic);
end mat_mul;


architecture rtl of mat_mul is

component mat_mul_fsm is

	port (clk, rst, start, fin_i, fin_k, fin_j, mul_done : in std_logic;
		clr, mul_start, en_i, en_k, en_j, en_x, c_wr, k_rst, j_rst, sdone: out std_logic);
end component;


component mul is
	port(clk ,rst ,start: in std_logic; xin, yin : in std_logic_vector (7 downto 0);
		result: out std_logic_vector (15 downto 0); cout, done: out std_logic);
end component;

-- uncomment both matrix_A and matrix_B, in case you want to use ROMs for the matrices. --
	
--component matrix_A is
--	port(addr: in std_logic_vector (3 downto 0); data: out std_logic_vector (7 downto 0)); 
--end component; 

--component matrix_B is 
--	port(addr: in std_logic_vector (3 downto 0); data: out std_logic_vector (7 downto 0)); 
--end component; 

	
	-- comment out the following two components, in case you want to use ROMs for the matrices. --	

component ram_a is 
	port(clk, wr : in std_logic; 
		data_in_addr : in std_logic_vector(3 downto 0);
		addr : in std_logic_vector(3 downto 0); 
		din : in std_logic_vector(7 downto 0);
		dout : out std_logic_vector(7 downto 0));
end component;
	
component ram_b is 
	port(clk, wr : in std_logic; 
		data_in_addr : in std_logic_vector(3 downto 0);
		addr : in std_logic_vector(3 downto 0); 
		din : in std_logic_vector(7 downto 0);
		dout : out std_logic_vector(7 downto 0));
end component; 

component matrix_C is 
	port(clk, wr : in std_logic; 
		addr : in std_logic_vector(3 downto 0); 
		din : in std_logic_vector(17 downto 0);
		dout : out std_logic_vector(17 downto 0));	
end component; 

component counter_x is
	port (clk, rst, en: in std_logic;
		count_out: out std_logic_vector(2 downto 0));
end component;

component counter_n is
	port (clk, rst, en: in std_logic;
		fin: out std_logic;
		count_out: out std_logic_vector(3 downto 0));
end component;

component counter_k is
	port (clk, rst, clr, en: in std_logic;
		fin: out std_logic;
		count_out: out std_logic_vector(2 downto 0));
end component;

component counter_j is
	port (clk, rst, clr, en: in std_logic;
		fin: out std_logic;
		count_out: out std_logic_vector(2 downto 0));
end component;

component adder_18bit is
	port(a : in std_logic_vector (17 downto 0);
		b : in std_logic_vector (15 downto 0);
		sum : out std_logic_vector (17 downto 0);
		cout: out std_logic);
end component;

component adder_3bit is
	port(a ,b : in std_logic_vector (2 downto 0);
		sum : out std_logic_vector (3 downto 0));
end component;

signal clr_int, en_i_int, fin_i_int, en_k_int, fin_k_int, en_j_int, fin_j_int, en_x_int, mat_c_wr, cout_adder, cout_mul, mul_start_int, mul_done_int
			,k_rst_int, j_rst_int : std_logic;
signal mat_a_out, mat_b_out : std_logic_vector(7 downto 0);
signal mat_a_addr, mat_b_addr, i_int: std_logic_vector(3 downto 0); 
signal x_int, j_int, k_int: std_logic_vector(2 downto 0);
signal mul_out: std_logic_vector(15 downto 0);
signal mat_c_out, adder_18bit_out: std_logic_vector(17 downto 0);

begin 

	c: matrix_C port map(clk, mat_c_wr, i_int, adder_18bit_out, mat_c_out);
	
	adder_18: adder_18bit port map(mat_c_out, mul_out, adder_18bit_out, cout_adder);
	
	fsm: mat_mul_fsm port map(clk, rst, start, fin_i_int, fin_k_int, fin_j_int, mul_done_int,
		clr_int, mul_start_int, en_i_int, en_k_int, en_j_int, en_x_int, mat_c_wr, k_rst_int, j_rst_int, done);
	
	
	


	i : counter_n port map (clk, clr_int, en_i_int, fin_i_int, i_int);
	k : counter_k port map (clk, clr_int, k_rst_int, en_k_int, fin_k_int, k_int);
	j : counter_j port map (clk, clr_int, j_rst_int, en_j_int, fin_j_int, j_int);
	x : counter_x port map (clk, clr_int, en_x_int, x_int);
	
	x_k_add: adder_3bit port map (x_int, k_int, mat_a_addr);
	j_k_add: adder_3bit port map (j_int, k_int, mat_b_addr);
		
	-- uncomment both matrix_A and matrix_B, in case you want to use ROMs for the matrices. --
	--a : matrix_A port map (mat_a_addr, mat_a_out);
	--b : matrix_B port map (mat_b_addr, mat_b_out);
		
	-- comment out the following two lines, in case you want to use ROMs for the matrices. --	
	a : ram_a port map(clk, mat_a_wr, a_addr, mat_a_addr, mat_a_in, mat_a_out);
	b : ram_b port map(clk, mat_b_wr, b_addr, mat_b_addr, mat_b_in, mat_b_out);
	
	multiplier: mul port map(clk ,clr_int ,mul_start_int, mat_a_out, mat_b_out, mul_out, cout_mul, mul_done_int);

		
end architecture rtl;

