-------------------------------------------------------------------------------
--
-- Title       : T21
-- Design      : T21
-- Author      : YASAN
-- Company     : .
--
-------------------------------------------------------------------------------
--
-- File        : E:\_Project\System Digital\T21\T21\T21\src\T21.vhd
-- Generated   : Sun Apr 17 20:46:50 2022
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
--{entity {T21} architecture {T21}}

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity T21 is
	port(
	input : in std_logic_vector(15 downto 0);
	output : out std_logic_vector(15 downto 0)
	
	);
	  
	
end T21;

--}} End of automatically maintained section

architecture T21 of T21 is
begin

	process(input) is 
	variable sum : integer :=0; 
	variable op : std_logic_vector(15 downto 0);
	begin 
		sum := 0;
		for	i in 0 to 15 loop 
			if	(input(i)= '0') then 
				sum := sum + 1;
			end if;
		end loop ;
		
		if (sum>10) then 
			op := std_logic_vector(not(unsigned(input)) + 1);
		else 	  
			op := std_logic_vector(unsigned(input) + 6);
		end if;
		output <= op;
	end process;
				

end T21;
