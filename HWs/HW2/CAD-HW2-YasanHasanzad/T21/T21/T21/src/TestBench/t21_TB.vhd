 library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity t21_tb is
end t21_tb;

architecture TB_ARCHITECTURE of t21_tb is
	-- Component declaration of the tested unit
	component t21
	port(
		input : in STD_LOGIC_VECTOR(15 downto 0);
		output : out STD_LOGIC_VECTOR(15 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal input : STD_LOGIC_VECTOR(15 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal output : STD_LOGIC_VECTOR(15 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : t21
		port map (
			input => input,
			output => output
		);

	process
	begin
		input <= ("0000011000010010") ;	
		wait for 10 ns;
		input <= ("1010101010101010") ;
		wait ;			  
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_t21 of t21_tb is
	for TB_ARCHITECTURE
		for UUT : t21
			use entity work.t21(t21);
		end for;
	end for;
end TESTBENCH_FOR_t21;

