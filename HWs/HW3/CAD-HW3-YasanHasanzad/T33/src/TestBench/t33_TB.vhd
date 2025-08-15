library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity t33_tb is
end t33_tb;

architecture TB_ARCHITECTURE of t33_tb is
	-- Component declaration of the tested unit
	component t33
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		x : in STD_LOGIC;
		a : out STD_LOGIC;
		b : out STD_LOGIC;
		z : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	signal x : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal a : STD_LOGIC;
	signal b : STD_LOGIC;
	signal z : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : t33
		port map (
			clk => clk,
			reset => reset,
			x => x,
			a => a,
			b => b,
			z => z
		);

	x <='1','0'after 10ns;
	clk <= '0', '1' after 2ns, '0' after 4ns,'1' after 6ns, '0' after 8ns, '1' after 10ns, '0' after 12ns,
	'1' after 14ns, '0' after 16ns, '1' after 18ns, '0' after 20ns; 
	reset <='0','1' after 15ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_t33 of t33_tb is
	for TB_ARCHITECTURE
		for UUT : t33
			use entity work.t33(t33);
		end for;
	end for;
end TESTBENCH_FOR_t33;

