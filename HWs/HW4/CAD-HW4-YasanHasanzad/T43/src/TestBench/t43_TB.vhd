library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity t43_tb is
end t43_tb;

architecture TB_ARCHITECTURE of t43_tb is
	-- Component declaration of the tested unit
	component t43
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		x : in STD_LOGIC;
		datain : in STD_LOGIC_VECTOR(15 downto 0);
		dataout : out STD_LOGIC_VECTOR(15 downto 0);
		valid : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	signal x : STD_LOGIC;
	signal datain : STD_LOGIC_VECTOR(15 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal dataout : STD_LOGIC_VECTOR(15 downto 0);
	signal valid : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : t43
		port map (
			clk => clk,
			reset => reset,
			x => x,
			datain => datain,
			dataout => dataout,
			valid => valid
		);
	   
	
Reset <= '0' , '1' after 1ns , '0' after 2ns;


--clock process 
Clock : process 
 begin 
  clk <='0';
  wait for 2ns;
  clk <= '1';
  wait for 2ns;
end process ; 

datain <= "1010101010101010";

process
begin 
	x <= '0';
	wait until reset ='0';
	wait until rising_edge(clk); x <= '0';
	wait until rising_edge(clk); x <= '0'; 
	wait until rising_edge(clk); x <= '1';
	wait until rising_edge(clk); x <= '0';
	
	wait until rising_edge(clk); x <= '0';
	wait until rising_edge(clk); x <= '1'; --0010 0100 1010 1100
	wait until rising_edge(clk); x <= '0';
	wait until rising_edge(clk); x <= '0';
	
	wait until rising_edge(clk); x <= '1';
	wait until rising_edge(clk); x <= '0';
	wait until rising_edge(clk); x <= '1';
	wait until rising_edge(clk); x <= '0';
	
	wait until rising_edge(clk); x <= '1';
	wait until rising_edge(clk); x <= '1';
	wait until rising_edge(clk); x <= '0';
	wait until rising_edge(clk); x <= '0';
end process;


	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_t43 of t43_tb is
	for TB_ARCHITECTURE
		for UUT : t43
			use entity work.t43(t43);
		end for;
	end for;
end TESTBENCH_FOR_t43;

