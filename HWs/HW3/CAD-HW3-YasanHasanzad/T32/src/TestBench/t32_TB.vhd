library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity t32_tb is
end t32_tb;

architecture TB_ARCHITECTURE of t32_tb is
	-- Component declaration of the tested unit
	component t32
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		command : in STD_LOGIC_VECTOR(1 downto 0);
		dataIn : in STD_LOGIC_VECTOR(5 downto 0);
		dataOut : out STD_LOGIC_VECTOR(5 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	signal command : STD_LOGIC_VECTOR(1 downto 0);
	signal dataIn : STD_LOGIC_VECTOR(5 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal dataOut : STD_LOGIC_VECTOR(5 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : t32
		port map (
			clk => clk,
			reset => reset,
			command => command,
			dataIn => dataIn,
			dataOut => dataOut
		);

	-- Add your stimulus here ...
	
	CLK <= '0', '1' after 2ns, '0' after 4ns,'1' after 6ns, '0' after 8ns, '1' after 10ns, '0' after 12ns,
	'1' after 14ns, '0' after 16ns, '1' after 18ns, '0' after 20ns;
	dataIn <= ('1', others => '0');
	command <= "01", "00" after 3ns, "10" after 9ns, "11" after 13ns, "01" after 17ns;
	reset <= '0' ,'1' after 18ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_t32 of t32_tb is
	for TB_ARCHITECTURE
		for UUT : t32
			use entity work.t32(t32);
		end for;
	end for;
end TESTBENCH_FOR_t32;

