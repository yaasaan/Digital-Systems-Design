library ieee;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity t23_tb is
end t23_tb;

architecture TB_ARCHITECTURE of t23_tb is
	-- Component declaration of the tested unit
	component t23
	port(
		a : in STD_LOGIC_VECTOR(0 to 31);
		b : in STD_LOGIC_VECTOR(0 to 31);
		cin : in STD_LOGIC;
		sin : in STD_LOGIC;
		func : in STD_LOGIC_VECTOR(0 to 3);
		sout : out STD_LOGIC;
		cout : out STD_LOGIC;
		ov : out STD_LOGIC;
		z : out STD_LOGIC_VECTOR(0 to 31) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal a : STD_LOGIC_VECTOR(0 to 31);
	signal b : STD_LOGIC_VECTOR(0 to 31);
	signal cin : STD_LOGIC;
	signal sin : STD_LOGIC;
	signal func : STD_LOGIC_VECTOR(0 to 3);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal sout : STD_LOGIC;
	signal cout : STD_LOGIC;
	signal ov : STD_LOGIC;
	signal z : STD_LOGIC_VECTOR(0 to 31);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : t23
		port map (
			a => a,
			b => b,
			cin => cin,
			sin => sin,
			func => func,
			sout => sout,
			cout => cout,
			ov => ov,
			z => z
		);

	-- Add your stimulus here ...
	process
	begin 
		
		b <= ("10000001000001000000100000100010");
		wait for 10ns;
		func <= ("0000");
		wait;
		
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_t23 of t23_tb is
	for TB_ARCHITECTURE
		for UUT : t23
			use entity work.t23(t23);
		end for;
	end for;
end TESTBENCH_FOR_t23;

