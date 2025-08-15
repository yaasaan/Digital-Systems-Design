library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity t31_tb is
end t31_tb;

architecture TB_ARCHITECTURE of t31_tb is
	-- Component declaration of the tested unit
	component t31
	port(
		qin : in STD_LOGIC;
		Y1 : out STD_LOGIC;
		Y2 : out STD_LOGIC;
		Y3 : out STD_LOGIC;
		Y4 : out STD_LOGIC;
		Y5 : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal qin : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Y1 : STD_LOGIC;
	signal Y2 : STD_LOGIC;
	signal Y3 : STD_LOGIC;
	signal Y4 : STD_LOGIC;
	signal Y5 : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : t31
		port map (
			qin => qin,
			Y1 => Y1,
			Y2 => Y2,
			Y3 => Y3,
			Y4 => Y4,
			Y5 => Y5
		);

	qin <= '0', '1' after 10 ns,'0' after 12 ns,'1' after 15 ns,'0' after 15.8 ns,'1' after 18 ns,'0' after 18.4 ns, '1'
	after 21 ns,'0' after 25 ns, '1' after 25.6ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_t31 of t31_tb is
	for TB_ARCHITECTURE
		for UUT : t31
			use entity work.t31(t31);
		end for;
	end for;
end TESTBENCH_FOR_t31;

