library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity reg_8bit is

	port (clk, rst, wr, shift_right: in std_logic;
		reg_in: in std_logic_vector(7 downto 0);
		reg_out: out std_logic_vector(7 downto 0));

end entity reg_8bit;

architecture rtl of reg_8bit is

	signal reg_temp: std_logic_vector(7 downto 0);
begin

process (rst, clk)
begin

	if (rst = '1') then
		reg_temp <= (others => '0');
	elsif (rising_edge(clk)) then
		case shift_right is
			when '0'=> 
					if (wr = '1') then
					 	reg_temp <= reg_in;
					end if;
				
			when '1' => reg_temp <= '0'&reg_temp(7 downto 1);
			when others => reg_temp <= reg_temp; --can be omitted
		end case;
	end if;

end process;
	reg_out <= reg_temp;
end architecture rtl;
