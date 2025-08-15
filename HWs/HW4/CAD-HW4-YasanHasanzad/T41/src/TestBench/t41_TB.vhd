library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity t41_tb is
end t41_tb;

architecture TB_ARCHITECTURE of t41_tb is
	-- Component declaration of the tested unit
	component t41
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		x : in STD_LOGIC;
		output : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	signal x : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal output : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : t41
		port map (
			clk => clk,
			reset => reset,
			x => x,
			output => output
		);
	
		
	reset <= '0';
		
 	process 
 	begin 
 	 	clk <='0';
  		wait for 1ns;
  		clk <= '1';
  		wait for 1ns;
	end process ;	   
	
	Process
	begin
		x<= '0';
		wait until reset = '0';
		wait until rising_edge(clk); x<='0';
		wait until rising_edge(clk); x<='0';
		wait until rising_edge(clk); x<='1';
		wait until rising_edge(clk); x<='1';
		
		wait until rising_edge(clk); x<='1';
		wait until rising_edge(clk); x<='0';
		wait until rising_edge(clk); x<='1';  --0011_1011_1001_0111_0111_0100
		wait until rising_edge(clk); x<='1';
		
		wait until rising_edge(clk); x<='1';
		wait until rising_edge(clk); x<='0';
		wait until rising_edge(clk); x<='0';
		wait until rising_edge(clk); x<='1';
		
		wait until rising_edge(clk); x<='0';
		wait until rising_edge(clk); x<='1';
		wait until rising_edge(clk); x<='1';
		wait until rising_edge(clk); x<='1';
		
		wait until rising_edge(clk); x<='0';
		wait until rising_edge(clk); x<='1';
		wait until rising_edge(clk); x<='1';
		wait until rising_edge(clk); x<='1';
		
		wait until rising_edge(clk); x<='0';
		wait until rising_edge(clk); x<='1';
		wait until rising_edge(clk); x<='0';
		wait until rising_edge(clk); x<='0';

	end process;
	
	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_t41 of t41_tb is
	for TB_ARCHITECTURE
		for UUT : t41
			use entity work.t41(t41);
		end for;
	end for;
end TESTBENCH_FOR_t41;

