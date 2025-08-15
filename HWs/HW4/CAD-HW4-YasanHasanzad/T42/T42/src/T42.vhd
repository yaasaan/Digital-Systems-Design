-------------------------------------------------------------------------------
--
-- Title       : T42
-- Design      : T42
-- Author      : YASAN
-- Company     : .
--
-------------------------------------------------------------------------------
--
-- File        : E:\_Project\System_Digital\T42\T42\src\T42.vhd
-- Generated   : Wed May 25 22:05:44 2022
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
--{entity {T42} architecture {T42}}

library IEEE;
use IEEE.std_logic_1164.all;

entity T42 is
	port(
	clk,reset : in std_logic;
	output : out std_logic_vector(3 downto 0)
	);
end T42;

--}} End of automatically maintained section

architecture T42 of T42 is
subtype T42_state is std_logic_vector(4 downto 0);
signal current_state , next_state : T42_state;

constant s0 : T42_state := "00000";
constant s1 : T42_state := "00001";
constant s3 : T42_state := "00011";
constant s61 : T42_state := "00110";
constant s62 : T42_state := "10110";
constant s8 : T42_state := "01000";


begin  
	
	REG : process(clk,reset)
	begin 
		if reset = '1' then 
			current_state <= s0;
		elsif clk'event and clk ='1' then 
			current_state <= next_state;
		end if;
	end process;
	
	CMB : process(current_state)
	begin
		case current_state is 
			when s0 => next_state <= s1;
			when s1 => next_state <= s3;
			when s3 => next_state <= s61;
			when s61 => next_state <= s62;
			when s62 => next_state <= s8;
			when s8 => next_state <= s0;
			when others => next_state <= s0;
		end case;	
	end process;
	
	output <= current_state(3 downto 0);
	 -- enter your statements here --

end T42;
