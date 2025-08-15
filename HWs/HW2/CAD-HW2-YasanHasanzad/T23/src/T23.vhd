-------------------------------------------------------------------------------
--
-- Title       : T23
-- Design      : T23
-- Author      : YASAN
-- Company     : .
--
-------------------------------------------------------------------------------
--
-- File        : E:\_Project\System Digital\T23\src\T23.vhd
-- Generated   : Sun Apr 24 20:00:40 2022
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
--{entity {T23} architecture {T23}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 
use ieee.STD_LOGIC_unsigned.all;

entity T23 is
	port(
	a,b :in std_logic_vector(0 to 31);
	cin,sin :in std_logic;
	func : in std_logic_vector(0 to 3);
	sout,cout,ov :out std_logic;
	z : out std_logic_vector(0 to 31)
	);
end T23;

--}} End of automatically maintained section

architecture T23 of T23 is
begin
	
	process
	variable aa,bb : std_logic_vector(0 to 31);
	variable ci : std_logic_vector(0 to 31);
	begin 
		aa := a;					   	
		bb := b;
		case func is 
			when "0000"	=> 
			if (bb(31)='0') then bb(31) := '1';
			else bb(31) := '0';
			end if;
			z<= bb;
			
			when "0001"	=>
			ci(0) := '0';
			for i in 0 to 31 loop
				z(i) <= aa(i) xor bb(i) xor ci(i);
				ci(i+1):= (aa(i) and bb(i) or (aa(i)) and ci(i)) or (bb(i) and ci(i));
				
			end loop;
			
			
			when "0010"	=>
			ci(0) := cin;
			for i in 0 to 31 loop
				z(i) <= aa(i) xor bb(i) xor ci(i);
				ci(i+1):= (aa(i) and bb(i) or (aa(i)) and ci(i)) or (bb(i) and ci(i));
			
			when "0011"	=>
			
			when "0100"	=>
			
			when "0101"	=>
			
			when "0110"	=> 
			z<= aa and bb;
			
			when "0111"	=> 
			z<= aa or bb;
			
			when "1000"	=> 
			z<= aa xor bb;
			
			when "1001"	=>
			
			when "1010"	=>
			
			when "1011"	=>
			
			when "1100"	=>
			
			when "1101"	=>
			if (aa>bb) then z <= "00000000000000000000000000000000001"
			else z <= "000000000000000000000000000000";
			end if;
			
			when "1110"	=>
			if (aa<bb) then z <= "00000000000000000000000000000000001"
			else z <= "000000000000000000000000000000";
			end if;
			
			when "1111"	=>
			if (aa=bb) then z <= "00000000000000000000000000000000001"
			else z <= "000000000000000000000000000000";
			end if;
			
			when others =>
			
			end case;
	
	end process;

	 -- enter your statements here --

end T23;
