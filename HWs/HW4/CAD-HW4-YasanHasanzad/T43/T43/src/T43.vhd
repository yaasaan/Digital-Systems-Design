-------------------------------------------------------------------------------
--
-- Title       : T43
-- Design      : T43
-- Author      : YASAN
-- Company     : .
--
-------------------------------------------------------------------------------
--
-- File        : E:\_Project\System_Digital\T43\T43\src\T43.vhd
-- Generated   : Thu May 26 00:01:29 2022
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
--{entity {T43} architecture {T43}}

library IEEE;
use IEEE.std_logic_1164.all;


entity T43 is 
	port( 
	clk , reset , x : in std_logic;
	datain : in  std_logic_vector(15 downto 0);
	
	dataout : out std_logic_vector(15 downto 0);
	valid :out std_logic
	
	);
end T43;

--}} End of automatically maintained section

architecture T43 of T43 is

type t43_state is(s0,s1,s2,s3,s4,s5,s6);
signal current_state , next_state :t43_state;

signal current_reg , dataout_reg: std_logic_vector(15 downto 0);
signal valid_reg : std_logic;

begin
	
	CP_SR : process(clk,reset)
	begin 
		if reset = '1' then 
			current_state <= s0;
		elsif clk'event and clk='1' then 
			current_state <= next_state;
		end if;
	end process;
	
	CP_NSL : process(current_state,x)
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
			if x= '0' then
				next_state <= s5;
				else next_state <= s3;
			end if;
			when s3 => 
			if x= '1' then
				next_state <= s4;
			else 
				next_state <= s2;
			end if;
			when s4 => 
			if x= '0' then
				next_state <= s0;
			else
				next_state <= s1;
			end if;
			when s5 => 
			if x= '1' then
				next_state <= s6;
			else
				next_state <= s0;
			end if;
			when s6 => 
			if x= '0' then
				next_state <= s0;
			else
				next_state <= s1;
			end if;
			when others => next_state <= s0;
		end case;
	end process;
	
	DP_R : process(clk , reset)
	begin
		dataout_reg <= (others => 'Z');
				valid_reg <= '0';
		if reset = '1' then 
			current_reg <= (others => '0');
			valid <= '0';
		elsif clk'event and clk ='1' then 
			if current_state = s6 then 
				current_reg <= datain;
			end if;
			
			if current_state = s4 then
				dataout_reg <= current_reg;
				valid_reg <= '1';
			else
				dataout_reg <= (others => 'Z');
				valid_reg <= '0';
			end if;
		end if;
			
	end process;
	
	dataout <= dataout_reg;
	valid <= valid_reg;
	

	 -- enter your statements here --

end T43;
