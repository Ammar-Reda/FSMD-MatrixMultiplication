library ieee,std, modelsim_lib;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use modelsim_lib.util.all;
use ieee.numeric_std.all;


entity mat_mul_tb is
end mat_mul_tb ;

architecture behav of mat_mul_tb is

    constant c_WIDTH : natural := 18;
	file vectors:text open read_mode is "mat_mul_vectors.vec";
	file result_vectors:text open write_mode is "mat_mul_results.vec";
	constant clockperiod:time:=100 ps;
	signal clk:std_logic:='1';
	signal rst, start, mat_a_wr, mat_b_wr: std_logic;
	signal mat_a_in, mat_b_in: std_logic_vector(7 downto 0);
	signal a_addr, b_addr: std_logic_vector(3 downto 0);
	signal done: std_logic;
	
	type ram_type is array (0 to 8) of std_logic_vector(17 downto 0);
	signal mat_c: ram_type; 
	
component mat_mul is
	port(clk ,rst ,start, mat_a_wr, mat_b_wr: in std_logic; 
		a_addr, b_addr: in std_logic_vector(3 downto 0);
		mat_a_in, mat_b_in: in std_logic_vector(7 downto 0);
		done: out std_logic);
end component;

begin


clk <= not clk after clockperiod /2;
rst <= '1' , '0' after 70 ps;
start <= '0', '1' after 1000 ps, '0' after 2000 ps;
mat_a_wr <='0', '1' after 70 ps;
mat_b_wr <='0', '1' after 70 ps;

dut:mat_mul port map(clk ,rst ,start, mat_a_wr, mat_b_wr, a_addr, b_addr, mat_a_in, mat_b_in, done);


spy_process : process
begin
init_signal_spy("/mat_mul_tb/dut/c/program","/mat_c", 1);             ---referencing matrix c values
wait;
end process spy_process;

process
variable vectorline, v_OLINE: line;
variable addr_a_var, addr_b_var: bit_vector(3 downto 0);
variable data_a_var, data_b_var: bit_vector(7 downto 0);
variable v_SPACE: character;
variable k: integer range 0 to 9;

begin

addr_a_var := "0000";
addr_b_var := "0000";
data_a_var := "00000000";
data_b_var := "00000000";

wait for clockperiod;
while(not endfile(vectors)) loop
readline(vectors, vectorline);

if vectorline(1)='#' then
next ;
end if;

read(vectorline, addr_a_var);
read(vectorline, v_SPACE);           -- read in the space character
read(vectorline, data_a_var);

read(vectorline, v_SPACE);           
read(vectorline, v_SPACE);           

read(vectorline, addr_b_var);
read(vectorline, v_SPACE);          

read(vectorline, data_b_var);

a_addr <= to_stdlogicvector(addr_a_var);
mat_a_in <= to_stdlogicvector(data_a_var);
b_addr <= to_stdlogicvector(addr_b_var);
mat_b_in <= to_stdlogicvector(data_b_var);

wait for clockperiod;
end loop;

wait for 82000 ps;


while(k<9) loop
	d: for i in 0 to 2 loop
		write(v_OLINE,  to_integer(ieee.numeric_std.unsigned(mat_c(k+i))), right, 1);
		write(v_OLINE, v_SPACE, right, 3);
	end loop d;
	writeline(result_vectors, v_OLINE);
	k:= k+3;
end loop;

wait for 3* clockperiod;
wait;
end process;
end behav;

