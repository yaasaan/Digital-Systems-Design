-------------------------------------------------------------------------------
--
-- Title       : T32
-- Design      : T32
-- Author      : YASAN
-- Company     : .
--
-------------------------------------------------------------------------------
--
-- File        : E:\_Project\System Digital\T32\T32\src\T32.vhd
-- Generated   : Sun May  8 22:05:06 2022
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
--{entity {T32} architecture {T32}}

library IEEE;
use Ieee.std_logic_1164.all;
use Ieee.numeric_std.all;

entity T32 is
	port(
	clk,reset : in std_logic;
	command : in std_logic_vector(1 downto 0);
	dataIn : in std_logic_vector(5 downto 0);
	dataOut : out std_logic_vector(5 downto 0)
	
	);
end T32;

--}} End of automatically maintained section

architecture T32 of T32 is	
signal reg : std_logic_vector(5 downto 0);

begin 
	
	
	--
	
	
	
	process(clk,reset,reg)
	begin
		
		if reset ='1' then 
			reg <= (others => '0');
		elsif clk'event and clk ='1' then 
			if(command= "01") then 
				reg <= dataIn;
			elsif(command = "11") then 
				reg <= std_logic_vector(unsigned(reg)+1);
			elsif(command ="10") then 
				reg <= std_logic_vector(shift_right(unsigned(reg),1));
			else
				reg <=reg;
			end if;
		end if;	
		
	end process;
	
	dataOut <= reg;

	 -- enter your statements here --

end T32;
