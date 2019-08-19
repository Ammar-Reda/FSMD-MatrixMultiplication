library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity mul_fsm is

port (clk, rst, start, fin, mul : in std_logic;
		shr ,shl ,wr, wrm, clr, count_en, sdone: out std_logic);
end mul_fsm;

architecture rtl of mul_fsm is
type state_type is (s_int, s_start, s_test, s_shf, s_multp, s_done, s_done2);
signal current_state, next_state: state_type;

begin
process (start,fin,mul, current_state)
begin
case current_state is

when s_int =>
	shr <= '0';
	shl <= '0';
	wr <= '0';
	clr <= '1';
	wrm <= '1';
	count_en <='0';
	sdone <='0';
		
if (start = '1') then
	next_state <= s_start;
else
	next_state <= s_int;
end if;

when s_start =>  
	shr <= '0';
	shl <= '0';
	wr <= '0';
	clr <= '0';
	wrm <= '1';
	count_en <='1';  -- counter start 
	sdone <='0';

	next_state <= s_test;


when s_test =>  -- test 
	shr <= '0';
	shl <= '0';
	wr <= '0';
	clr <= '0';
	wrm <= '0';
	count_en <='0';   
	sdone <='0';
if (mul = '1') then
	next_state <= s_multp;
else
	next_state <= s_shf;
end if;

when s_shf =>
	shr <= '1';
	shl <= '1';
	wr <= '0';
	clr <= '0';
	wrm <= '0';
	count_en <='1';  
	--sdone <='0';

if (fin = '0') then
	sdone <='0';
	next_state <= s_test;
else
	sdone<= '1';
	next_state <= s_done;
end if;


when s_multp =>
	shr <= '0';
	shl <= '0';
	wr <= '1';
	clr <= '0';
	wrm <= '0';
	count_en <='0';  

	sdone <='0';


	next_state <= s_shf;

when s_done =>
	shr <= '0';
	shl <= '0';
	wr <= '1';
	clr <= '0';
	wrm <= '0';
	count_en <='0';  
	sdone <='1';

	next_state <= s_int;



when others =>
	shr <= '0';
	shl <= '0';
	wr <= '0';
	clr <= '1';
	wrm <= '0';
	count_en <='0';  
	sdone <='0';

	next_state <= s_int;
end case;
end process;
process (rst, clk)
begin
if (rst = '1') then
current_state <= s_int;
elsif (rising_edge(clk)) then
current_state <= next_state;
end if;
end process;
end rtl;
