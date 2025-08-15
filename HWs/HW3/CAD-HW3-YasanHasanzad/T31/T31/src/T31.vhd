-------------------------------------------------------------------------------
--
-- Title       : T31
-- Design      : T31
-- Author      : YASAN
-- Company     : .
--
-------------------------------------------------------------------------------
--
-- File        : E:\_Project\System Digital\T31\T31\src\T31.vhd
-- Generated   : Sun May  8 21:19:21 2022
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
--{entity {T31} architecture {T31}}

library ieee;
use ieee.std_logic_1164.all;

entity T31 is
	port(
		qin : in std_logic;
		Y1,Y2,Y3,Y4,Y5 : out std_logic
	);
	
end T31;

--}} End of automatically maintained section

architecture T31 of T31 is
begin

	Y1 <= qin;
	Y2 <= qin after 1ns;
	Y3 <= inertial qin after 1ns;
	Y4 <= transport qin after 1ns;
	Y5 <= reject 500ps inertial qin after 1ns;

end T31;
