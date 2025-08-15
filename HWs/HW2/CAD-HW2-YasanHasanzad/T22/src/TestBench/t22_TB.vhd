library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity t22_tb is
end t22_tb;

architecture TB_ARCHITECTURE of t22_tb is
	-- Component declaration of the tested unit
	component t22
	port(
		input : in STD_LOGIC_VECTOR(5 downto 0);
		output : out STD_LOGIC_VECTOR(63 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal input : STD_LOGIC_VECTOR(5 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal output : STD_LOGIC_VECTOR(63 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : t22
		port map (
			input => input,
			output => output
		);
		process 
		begin 
			input <= ("111111");
			wait for 10 ns;
			input <= ("000000");
			wait for 10 ns;
			input <= ("110101");
			wait; 
		end process;
			

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_t22 of t22_tb is
	for TB_ARCHITECTURE
		for UUT : t22
			use entity work.t22(t22);
		end for;
	end for;
end TESTBENCH_FOR_t22;

