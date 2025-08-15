-------------------------------------------------------------------------------
--
-- Title       : T41
-- Design      : T41
-- Author      : YASAN
-- Company     : .
--
-------------------------------------------------------------------------------
--
-- File        : E:\_Project\System_Digital\T41\T41\src\T41.vhd
-- Generated   : Wed May 25 17:09:57 2022
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {T41} architecture {T41}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity T41 is
	port(
	clk , reset : in std_logic;
	x : in std_logic;
	output : out std_logic
	);
end T41;

--}} End of automatically maintained section

architecture T41 of T41 is
type t41_state is (s0,s1,s2,s3,s4,s5);
signal current_state , next_state : t41_state;
begin
	
	REG : process(clk,reset)
	begin 
		if reset='1' then 
			current_state <=s0;
		elsif clk'event and clk='1'then
			current_state <= next_state;
		end if; 
	end process;
	
	CMB : process(current_state,x)
	begin
		case current_state is 
			when s0 => 
			if x='1' then 
				next_state <= s1;
			else
				next_state <= s0;
			end if;
			
			when s1 => 
			if x='0' then 
				next_state <= s2;
			else
				next_state <= s1;
			end if;
			
			when s2 => 
			if x='1' then 
				next_state <= s3;
			else
				next_state <= s0;
			end if;
			
			when s3 => 
			if x='1' then 
				next_state <= s4;
			else
				next_state <= s2;
			end if;
			
			when s4 => 
			if x='1' then 
				next_state <= s5;
			else
				next_state <= s2;
			end if;
			
			when s5 => 
			if x='0' then 
				next_state <= s2;
			else
				next_state <= s1;
			end if;
			
		end case;	
			
	end process; 
	
	output <= '1' when(current_state = s5 and next_state = s2) else '0';
	
	

	 -- enter your statements here --

end T41;
