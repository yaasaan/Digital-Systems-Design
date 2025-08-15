library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity VGA_Square is
  port ( CLK_24MHz		: in std_logic;
			RESET				: in std_logic;
			ColorOut			: out std_logic_vector(5 downto 0); -- RED & GREEN & BLUE
			ScanlineX		: in std_logic_vector(10 downto 0);
			ScanlineY		: in std_logic_vector(10 downto 0);
			sevenseg			: out bit_vector(7 downto 0);
			segout			: out bit_vector(3 downto 0);
			Key 				: in std_logic_vector(3 downto 0);
			SW 				: in std_logic_vector(7 downto 0);
			Leds 				: out std_logic_vector(7 downto 0)
  );
end VGA_Square;

architecture Behavioral of VGA_Square is

	signal ColorOutput: std_logic_vector(5 downto 0);

	type GROUND_STATE is (EMPTY,SNAKE,APPLE);--(BLANCK,BOMB,BOMBAREA)
	type DIRECTION is (LEFT,RIGHT,UP,DOWN);
	type GROUND_TYPE is array (0 to 19, 0 to 19) of GROUND_STATE ;
	signal ground: GROUND_TYPE := ((others=> (others=>EMPTY)));
	signal gameEnded,win,gameStart : bit:='0';
	signal init : bit:='0';
	
	signal snake_dir : DIRECTION:=LEFT;
	signal posx,posy,sn_posx,sn_posy: integer := 0;
	
	signal Prescaler,prescalerspeed: std_logic_vector(30 downto 0) := (others => '0');
	signal pseudo_rand1 : std_logic_vector(31 downto 0) :=(others => '0');
	signal apple_randy , apple_randx ,snake_randy ,snake_randx  :integer range 0 to 31 :=0;
	signal snake_randy_next  :integer range 0 to 19 :=18;
	signal snake_randx_next  :integer range 0 to 19 :=3;
	signal apple_randy_next  :integer range 0 to 19 :=10;
	signal apple_randx_next  :integer range 0 to 19 :=6;
	
	
	type POSITION_ARRAY is array (0 to 20) of integer ;
	constant startPositionsX : POSITION_ARRAY := (100,122,144,166,188,210,232,254,276,296,320,342,364,386,408,430,452,474,496,518,540);
	constant startPositionsY : POSITION_ARRAY := (20,42,64,86,108,130,152,174,196,218,240,262,284,306,328,350,372,394,416,438,460);
	
	
	signal time_10,time_01,point_10,point_01 :integer range 0 to 9 :=0;
	signal countForoneSeccond : std_logic_vector(25 downto 0) := (others => '0');
	signal times,point: integer := 0;
	signal point_10_next , point_01_next , point_next : integer range 0 to 9 :=0;
	
	type numberLookup is array (0 to 9) of bit_vector(7 downto 0) ;
	signal sevensegmentStates : bit_vector(3 downto 0):= "1110";
	signal sevensegmentNextState : bit_vector(3 downto 0):= "1110";
	signal sg0,sg1,sg2,sg3,sevensegmentOut : bit_vector(7 downto 0):=x"c0";
	constant sevenSegLookup  : numberLookup := (x"c0",x"F9",x"A4",x"B0",x"99",x"92",x"82",x"F8",x"80",x"98");
	
	signal enable_apple : bit := '0';
	
begin

------------------------------- randomize ---------------------------------

	randomize: process(CLK_24MHz, RESET)
		
		function lfsr32(x : std_logic_vector(31 downto 0)) return std_logic_vector is
			begin
			return x(30 downto 0) & (x(0) xnor x(1) xnor x(21) xnor x(31));
		end function;
	begin
		if RESET = '1' then
			pseudo_rand1 <= (others => '0');
			
			snake_randy_next <= 13;
			snake_randx_next <= 10;
			apple_randy_next <= 2;
			apple_randx_next <= 18;

		elsif rising_edge(CLK_24MHz) then
			
			pseudo_rand1 <= lfsr32(pseudo_rand1);
			pseudo_rand1 <= lfsr32(pseudo_rand1);
			pseudo_rand1 <= lfsr32(pseudo_rand1);
			
			
			snake_randy_next <= CONV_INTEGER( pseudo_rand1(3 downto 0));
			snake_randx_next <= CONV_INTEGER( pseudo_rand1(7 downto 4));
			apple_randy_next <= CONV_INTEGER( pseudo_rand1(11 downto 8));
			apple_randx_next <= CONV_INTEGER( pseudo_rand1(15 downto 12));
			
		end if;
	end process randomize; 
	
	--------------------------------------------------------------
		snake_randy <= snake_randy_next;
		snake_randx <= snake_randx_next;
		apple_randy <= apple_randy_next;
		apple_randx <= apple_randx_next;

-----------------------7segment----------------------------------

	sg0 <= sevenSegLookup(point_10) when gameStart='1' 
			else sevenSegLookup(4);
	sg1 <= sevenSegLookup(point_01) when gameStart='1' 
			else sevenSegLookup(4);
	sg2 <= sevenSegLookup(time_10) when gameStart='1' 
			else sevenSegLookup(4);
	sg3 <= sevenSegLookup(time_01) when gameStart='1' 
			else sevenSegLookup(3);
			
------------------7segment States--------------------------------
			
	process(sevensegmentStates,sg0,sg1,sg2,sg3)
	begin
		sevensegmentNextState<="1110";
			case sevensegmentStates is
				when "1110" =>
				sevensegmentNextState<="1101";
				sevensegmentOut <= sg0;
				when "1101" =>
				sevensegmentNextState<="1011";
				sevensegmentOut <= sg1;
				when "1011" =>
				sevensegmentNextState<="0111";
				sevensegmentOut <= sg2;
				when "0111" =>
				sevensegmentNextState<="1110";
				sevensegmentOut <= sg3;
				when others =>
				sevensegmentOut <= sevenSegLookup(0);
			end case;
	end process;
	
	------------------------7segment nextState--------------------------
	svnsegmentNextState: process(CLK_24MHz, RESET)
		variable counter : integer range 0 to 5000 :=0;  --5000
	begin
		if RESET = '1' then
			sevensegmentStates<="1110";
		elsif rising_edge(CLK_24MHz) then
			
			counter := counter +1;
			if (counter = 4999) then --4999
				counter :=0;
				sevensegmentStates<=sevensegmentNextState;
			end if;
		end if;
	end process svnsegmentNextState;
	
	segout <= sevensegmentStates;
	sevenseg <= sevensegmentOut;
	
	-----------------------------------------------------------------
	
	point <= point_next;
	
	-------------------timer----------------------------------------
	timer: process(CLK_24MHz, RESET)
	begin
		if RESET = '1' then
			countForoneSeccond <= (others => '0');
			times <= 0;
			time_10 <= 0;
			time_01 <= 0;
			point_10 <= 0;
			point_01 <= 0;
			gameEnded<= '0';
			win <= '0';
		elsif rising_edge(CLK_24MHz) then
			if gameStart='1' then
				if gameEnded='0' then
					countForoneSeccond <= countForoneSeccond+1;
					if countForoneSeccond = "1011011100011011000000000" then  -- Activated every 0,002 sec (2 msec) 
														--24,000,000-
						if	point>=10 then
							gameEnded <= '1';
							win <= '1';
							
							point_10 <= point/10;
							point_01 <= point mod 10;
						else 
							point_10 <= point/10;
							point_01 <= point mod 10;
							
							if times<99 then			
								times <= times+1;
								if time_01<9 then
									time_01<= time_01+1;
								else
									time_01<=0;
									time_10<=time_10+1;
								end if;
							else
								times <= 88;
								time_01<=8;
								time_10<=8;
								point_01<=8;--  emp
								point_10<=8;--  emp
								gameEnded <= '1';
								win <= '1';
							end if; -- times<99
						end if; -- point>10
						
						
						countForoneSeccond <= (others => '0');
					end if; --countForoneSeccond =10110----
						
				end if; --gameEnded='0'
			end if;  --gameStart='1'
		end if;  --RESET = '1' 
	end process timer; 
	
	
	-----------------prescalerCounter-----------------------------------
	
	
	
	PrescalerCounter: process(CLK_24MHz, RESET)
	
	
	begin
		if RESET = '1' then
		
			enable_apple <= '0';
			
			point_next <= 0;
			gameStart<='0';
			Prescaler <= (others => '0');
			init <= '0';

			snake_dir <= LEFT;
			ground <= ((others=> (others=>EMPTY)));
			prescalerspeed<= "0000000100110001001011010000000";  --10,000,000
			
		elsif rising_edge(CLK_24MHz) then
		
			prescalerspeed<= "0000000100110001001011010000000";
		
	
			if init='0' then
			
--				if	(snake_randy = apple_randy) then
--					apple_randy <= apple_randy + 1;
--				else 
--					apple_randy <= apple_randy;
--				end if;
--				
--				if	(snake_randx = apple_randx) then
--					apple_randx <= apple_randx + 1;
--				else 
--					apple_randx <= apple_randx;
--				end if;
			
				ground(snake_randy,snake_randx)<=SNAKE;
				ground(apple_randy,apple_randx)<=APPLE;
				sn_posy <= snake_randy ;
				sn_posx <= snake_randx ;
			
				
				init <= '1';				
			
			else -- init = '1'
				if gameEnded='0' and gameStart = '1' then
				

				
					if enable_apple = '1' then
	
--						if	(sn_posy = apple_randy) then
--							apple_randy <= apple_randy + 1;
--						else 
--							apple_randy <= apple_randy;
--						end if;
--							
--						if	(sn_posx = apple_randx) then
--							apple_randx <= apple_randx + 1;
--						else 
--							apple_randx <= apple_randx;
--						end if;
						
						ground(apple_randy,apple_randx)<=APPLE;
						enable_apple <= '0';
					end if;
						
					Prescaler <= Prescaler + 1;
						
					if Prescaler = prescalerspeed then
					
						if snake_dir = UP and sn_posy >0 and (ground(sn_posy-1,sn_posx)=EMPTY or ground(sn_posy-1,sn_posx)=APPLE) then
							if ground(sn_posy-1,sn_posx)=APPLE then 
								point_next <= point_next+1;
								enable_apple <= '1';
							end if ;
							
							sn_posy<=sn_posy-1;
							ground(sn_posy,sn_posx)<=EMPTY;
							ground(sn_posy-1,sn_posx)<=SNAKE;
							
						elsif snake_dir =DOWN and sn_posy<19 and (ground(sn_posy+1,sn_posx)=EMPTY or ground(sn_posy+1,sn_posx)=APPLE) then
							if ground(sn_posy+1,sn_posx)=APPLE then 
								point_next <= point_next+1;
								enable_apple <= '1';
							end if ;
							
							sn_posy<=sn_posy+1;
							ground(sn_posy,sn_posx)<=EMPTY;
							ground(sn_posy+1,sn_posx)<=SNAKE;
							
						elsif snake_dir =RIGHT and sn_posx<19 and (ground(sn_posy,sn_posx+1)=EMPTY or ground(sn_posy,sn_posx+1)=APPLE) then
							if ground(sn_posy,sn_posx+1)=APPLE then 
								point_next <= point_next+1;
								enable_apple <= '1';
							end if ;
							
							sn_posx<=sn_posx+1;
							ground(sn_posy,sn_posx)<=EMPTY;
							ground(sn_posy,sn_posx+1)<=SNAKE;
							
						elsif snake_dir =LEFT and sn_posx>0 and (ground(sn_posy,sn_posx-1)=EMPTY or ground(sn_posy,sn_posx-1)=APPLE) then
							if ground(sn_posy,sn_posx-1)=APPLE then 
								point_next <= point_next+1;
								enable_apple <= '1';
							end if ;
							
							sn_posx<=sn_posx-1;
							ground(sn_posy,sn_posx)<=EMPTY;
							ground(sn_posy,sn_posx-1)<=SNAKE;
							
						end if ;
						
						Prescaler <= (others => '0');
					end if;  -- Prescaler = prescalerspeed 
					
					
					if key(0)='0' and not(snake_dir = DOWN)then --up
						if sn_posy>0 and (ground(sn_posy-1,sn_posx)=EMPTY or ground(sn_posy-1,sn_posx)=APPLE)  then
							snake_dir<=UP;
						end if;
					elsif key(3)='0' and not(snake_dir = UP) then--down
						if sn_posy<19 and (ground(sn_posy+1,sn_posx)=EMPTY or ground(sn_posy+1,sn_posx)=APPLE)  then
							snake_dir<= DOWN;
						end if;
					elsif key(1)='0' and not(snake_dir = LEFT) then --right
						if sn_posx<19 and (ground(sn_posy,sn_posx+1)=EMPTY or ground(sn_posy,sn_posx+1)=APPLE) then
							snake_dir<= RIGHT;
						end if;
					elsif key(2)='0' and not(snake_dir = RIGHT) then --left
						if sn_posx>0 and (ground(sn_posy,sn_posx-1)=EMPTY or ground(sn_posy,sn_posx-1)=APPLE)  then
							snake_dir<= LEFT;
						end if;
					end if; -- key(0)='0'
					
	
				end if; -- gameend='0'
				
				if key(0)='0' or  key(1)='0' or key(2)='0' or key(3)='0' then --up
					gameStart<= '1';
				end if ;
				
			end if;-- init = '1'
		end if;-- clock
	end process PrescalerCounter; 
	
	
	--------------------------posX and posY------------------------------
	
	posx <= 0 when ScanlineX>=conv_std_logic_vector(100,10) and ScanlineX<conv_std_logic_vector(122,10)
				else 1 when ScanlineX>=conv_std_logic_vector(122,10) and ScanlineX<conv_std_logic_vector(144,10)
				else 2 when ScanlineX>=conv_std_logic_vector(144,10) and ScanlineX<conv_std_logic_vector(166,10)
				else 3 when ScanlineX>=conv_std_logic_vector(166,10) and ScanlineX<conv_std_logic_vector(188,10)
				else 4 when ScanlineX>=conv_std_logic_vector(188,10) and ScanlineX<conv_std_logic_vector(210,10)
				else 5 when ScanlineX>=conv_std_logic_vector(210,10) and ScanlineX<conv_std_logic_vector(232,10)
				else 6 when ScanlineX>=conv_std_logic_vector(232,10) and ScanlineX<conv_std_logic_vector(254,10)
				else 7 when ScanlineX>=conv_std_logic_vector(254,10) and ScanlineX<conv_std_logic_vector(276,10)
				else 8 when ScanlineX>=conv_std_logic_vector(276,10) and ScanlineX<conv_std_logic_vector(298,10)
				else 9 when ScanlineX>=conv_std_logic_vector(298,10) and ScanlineX<conv_std_logic_vector(320,10)
				else 10 when ScanlineX>=conv_std_logic_vector(320,10) and ScanlineX<conv_std_logic_vector(342,10)
				else 11 when ScanlineX>=conv_std_logic_vector(342,10) and ScanlineX<conv_std_logic_vector(364,10)
				else 12 when ScanlineX>=conv_std_logic_vector(364,10) and ScanlineX<conv_std_logic_vector(386,10)
				else 13 when ScanlineX>=conv_std_logic_vector(386,10) and ScanlineX<conv_std_logic_vector(408,10)
				else 14 when ScanlineX>=conv_std_logic_vector(408,10) and ScanlineX<conv_std_logic_vector(430,10)
				else 15 when ScanlineX>=conv_std_logic_vector(430,10) and ScanlineX<conv_std_logic_vector(452,10)
				else 16 when ScanlineX>=conv_std_logic_vector(452,10) and ScanlineX<conv_std_logic_vector(474,10)
				else 17 when ScanlineX>=conv_std_logic_vector(474,10) and ScanlineX<conv_std_logic_vector(496,10)
				else 18 when ScanlineX>=conv_std_logic_vector(496,10) and ScanlineX<conv_std_logic_vector(518,10)
				else 19 when ScanlineX>=conv_std_logic_vector(518,10) and ScanlineX<conv_std_logic_vector(540,10);
				

				
	posy <= 0 when ScanlineY>=conv_std_logic_vector(20,10) and ScanlineY<conv_std_logic_vector(42,10)
				else 1 when ScanlineY>=conv_std_logic_vector(42,10) and ScanlineY<conv_std_logic_vector(64,10)
				else 2 when ScanlineY>=conv_std_logic_vector(64,10) and ScanlineY<conv_std_logic_vector(86,10)
				else 3 when ScanlineY>=conv_std_logic_vector(86,10) and ScanlineY<conv_std_logic_vector(108,10)
				else 4 when ScanlineY>=conv_std_logic_vector(108,10) and ScanlineY<conv_std_logic_vector(130,10)
				else 5 when ScanlineY>=conv_std_logic_vector(130,10) and ScanlineY<conv_std_logic_vector(152,10)
				else 6 when ScanlineY>=conv_std_logic_vector(152,10) and ScanlineY<conv_std_logic_vector(174,10)
				else 7 when ScanlineY>=conv_std_logic_vector(174,10) and ScanlineY<conv_std_logic_vector(196,10)
				else 8 when ScanlineY>=conv_std_logic_vector(196,10) and ScanlineY<conv_std_logic_vector(218,10)
				else 9 when ScanlineY>=conv_std_logic_vector(218,10) and ScanlineY<conv_std_logic_vector(240,10)
				else 10 when ScanlineY>=conv_std_logic_vector(240,10) and ScanlineY<conv_std_logic_vector(262,10)
				else 11 when ScanlineY>=conv_std_logic_vector(262,10) and ScanlineY<conv_std_logic_vector(284,10)
				else 12 when ScanlineY>=conv_std_logic_vector(284,10) and ScanlineY<conv_std_logic_vector(306,10)
				else 13 when ScanlineY>=conv_std_logic_vector(306,10) and ScanlineY<conv_std_logic_vector(328,10)
				else 14 when ScanlineY>=conv_std_logic_vector(328,10) and ScanlineY<conv_std_logic_vector(350,10)
				else 15 when ScanlineY>=conv_std_logic_vector(350,10) and ScanlineY<conv_std_logic_vector(372,10)
				else 16 when ScanlineY>=conv_std_logic_vector(372,10) and ScanlineY<conv_std_logic_vector(394,10)
				else 17 when ScanlineY>=conv_std_logic_vector(394,10) and ScanlineY<conv_std_logic_vector(416,10)
				else 18 when ScanlineY>=conv_std_logic_vector(416,10) and ScanlineY<conv_std_logic_vector(438,10)
				else 19 when ScanlineY>=conv_std_logic_vector(438,10) and ScanlineY<conv_std_logic_vector(460,10);
	
--------------------colorOutPut--------------------------

ColorOutput <= "101010" when (ScanlineY>="0000000000" and ScanlineY<"0000010100") or (ScanlineX>="0000000000" and ScanlineX<"0001100100") or (ScanlineY>="0111001100" and ScanlineY<"0111100000" )or (ScanlineX>="1000011100" and ScanlineX<"1010000000") -- outside wall : gray
						
						else "001100" when gameEnded='1' and win='1' -- win : green
						else "110000" when gameEnded='1'  -- lose : red
						else "111111" when ground(posy,posx)=EMPTY
						else "110000" when ground(posy,posx)=APPLE
						else "001100" when ground(posy,posx)=SNAKE
						else "000011";

-------------------------------------------------------------
	ColorOut <= ColorOutput;
	Leds <= "11111111" when gameEnded='1'
		else "00000000";

----------------------------------------------	

end Behavioral;

