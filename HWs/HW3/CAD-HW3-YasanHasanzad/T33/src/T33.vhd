-------------------------------------------------------------------------------
--
-- Title       : T33
-- Design      : T33
-- Author      : YASAN
-- Company     : .
--
-------------------------------------------------------------------------------
--
-- File        : E:\_Project\System Digital\T33\T33\src\T33.vhd
-- Generated   : Sun May  8 23:21:15 2022
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
--{entity {T33} architecture {T33}}

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity T33 is 
	port(
	clk ,reset, x : in std_logic;
	a,b,z : out std_logic
	);
	
end T33;

--}} End of automatically maintained section

architecture T33 of T33 is
signal d0 ,d1, b_temp,a_temp: std_logic;

begin 
	 
		d0 <=x;
		d1 <= (not x)and(b_temp);	
	
	process(reset,clk)
	begin
		
		if(reset = '1') then 
			z <= '0';
		elsif clk'event and clk='0' then 
			b_temp <= d0;
			a_temp <= d1;
		end if;
		
	end process;
	
	z <= x and a_temp;
	b<= b_temp;
	a<= a_temp;

end T33;
