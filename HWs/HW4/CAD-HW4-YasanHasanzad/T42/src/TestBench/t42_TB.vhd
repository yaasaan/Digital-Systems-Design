library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity t42_tb is
end t42_tb;

architecture TB_ARCHITECTURE of t42_tb is
	-- Component declaration of the tested unit
	component t42
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		output : out STD_LOGIC_VECTOR(3 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal output : STD_LOGIC_VECTOR(3 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : t42
		port map (
			clk => clk,
			reset => reset,
			output => output
		);
		

Reset <= '0' , '1' after 3ns , '0' after 6ns ;


--clock process 
Clock : process 
 begin 
  clk <='0';
  wait for 5ns;
  clk <= '1';
  wait for 5ns;
end process ;
	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_t42 of t42_tb is
	for TB_ARCHITECTURE
		for UUT : t42
			use entity work.t42(t42);
		end for;
	end for;
end TESTBENCH_FOR_t42;

