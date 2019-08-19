library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity mat_mul_fsm is

port (clk, rst, start, fin_i, fin_k, fin_j, mul_done : in std_logic;
		clr, mul_start, en_i, en_k, en_j, en_x, c_wr, k_rst, j_rst, sdone: out std_logic);
end mat_mul_fsm;

architecture rtl of mat_mul_fsm is
type state_type is (s_int, s_1, s_2, s_3, s_4, s_5, s_6, s_7, s_8, s_9);
signal current_state, next_state: state_type;

begin
process (start, fin_i, fin_k, fin_j, mul_done, current_state)
begin
case current_state is

when s_int =>
	clr <= '1';
	
	en_i <= '0';
	en_k <= '0';
	en_j <= '0';
	en_x <= '0';
	
	mul_start <= '0';
	c_wr <= '0';
	
	k_rst <= '0';
	j_rst <= '0';
	sdone <= '0';
	

if (start = '1') then
	next_state <= s_1;
else
	next_state <= s_int;
end if;

when s_1 =>  ---i/n loop
	clr <= '0';
	
	en_i <= '0';
	en_k <= '0';
	en_j <= '0';
	en_x <= '0';
	
	mul_start <='0';
	c_wr <= '0';
	
	k_rst <= '0';
	j_rst <= '0';
	sdone <= '0';
	
if (fin_i = '1') then
	next_state <= s_9;
else
	next_state <= s_2;
end if;



when s_2 =>     --- k loop 
	clr <= '0';
	
	en_i <= '0';
	en_k <= '0';
	en_j <= '0';
	en_x <= '0';
	
	mul_start <='0';
	c_wr <= '0';
	
	k_rst <= '0';
	j_rst <= '0';
	sdone <= '0';
		
if (fin_k = '1') then
	next_state <= s_6;
else
	next_state <= s_3;
end if;

when s_3 =>
	clr <= '0';
	
	en_i <= '0';
	en_k <= '0';
	en_j <= '0';
	en_x <= '0';
	
	mul_start <='1';
	c_wr <= '0';
	
	k_rst <= '0';
	j_rst <= '0';
	sdone <= '0';
	

	next_state <= s_4;


when s_4 =>
	clr <= '0';
	
	en_i <= '0';
	en_k <= '0';
	en_j <= '0';
	en_x <= '0';
	
	mul_start <='0';
	c_wr <= '0';
	
	k_rst <= '0';
	j_rst <= '0';
	sdone <= '0';

if (mul_done = '1') then
	next_state <= s_5;
else
	next_state <= s_4;
end if;


when s_5 =>  --- end of k loop
	clr <= '0';
	
	en_i <= '0';

	en_k <='1';
	
	en_j <= '0';
	en_x <= '0';
	
	mul_start <='0';
	c_wr <= '1';
	
	k_rst <= '0';
	j_rst <= '0';
	sdone <= '0';
	
	next_state <= s_2;

when s_6=>
	clr <= '0';
	
	en_i <= '0';
	en_k <= '0';
	
	
	en_j <= '1';
	en_x <= '0';
	
	mul_start <= '0';
	c_wr <= '0';
	
	k_rst <= '1';
	j_rst <= '0';
	sdone <= '0';
	
	next_state <= s_7;
	
	
when s_7 =>   
	clr <= '0';
	
	en_i <= '1';
	en_k <= '0';
	en_j <= '0';
	en_x <= '0';
	
	mul_start <= '0';
	c_wr <= '0';
	
	k_rst <= '0';
	j_rst <= '0';
	sdone <= '0';

if (fin_j = '1') then
	next_state <= s_8;
else
	next_state <= s_1;
end if;
	
	
when s_8 =>
	clr <= '0';
	
	en_i <= '0';
	en_k <= '0';
	en_j <= '0';
	en_x <= '1';
	
	mul_start <= '0';
	c_wr <= '0';
	
	k_rst <= '0';
	j_rst <= '1';
	sdone <= '0';

	next_state <= s_1;

when s_9 =>
	clr <= '0';
	
	en_i <= '0';
	en_k <= '0';
	en_j <= '0';
	en_x <= '0';
	
	mul_start <='0';
	c_wr <= '0';
	
	k_rst <= '0';
	j_rst <= '0';
	sdone <= '1';
	
	next_state <= s_int;
	
when others =>
	clr <= '0';
	
	en_i <= '0';
	en_k <= '0';
	en_j <= '0';
	en_x <= '0';
	
	mul_start <= '0';
	c_wr <= '0';
	
	k_rst <= '0';
	j_rst <= '0';
	sdone <= '0';

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

