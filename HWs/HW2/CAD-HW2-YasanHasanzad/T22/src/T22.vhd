-------------------------------------------------------------------------------
--
-- Title       : T22
-- Design      : T22
-- Author      : YASAN
-- Company     : .
--
-------------------------------------------------------------------------------
--
-- File        : E:\_Project\System Digital\T22\T22\src\T22.vhd
-- Generated   : Mon Apr 18 19:13:21 2022
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
--{entity {T22} architecture {T22}}



library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;


entity T22 is	
	port (	  
	input : in std_logic_vector(5 downto 0);
	output : out std_logic_vector(63 downto 0)
	
	);
	
end T22;

--}} End of automatically maintained section

architecture T22 of T22 is
begin		   
	
	process(input)
	variable op : unsigned(63 downto 0);
	begin 
		op :=(others =>'0');
		op(0) := '1';		  
		
		if input(5) = '1' then 
			op := op sll 32;
		end if;
		if input(4) = '1' then 
			op := op sll 16;
		end if;
		if input(3) = '1' then 
			op := op sll 8;
		end if;
		if input(2) = '1' then 
			op := op sll 4;
		end if;
		if input(1) = '1' then 
			op := op sll 2;
		end if;
		if input(0) = '1' then 
			op := op sll 1;
		end if;
		output <= std_logic_vector(op);
	end process;
 

end T22;
