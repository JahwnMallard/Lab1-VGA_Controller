----------------------------------------------------------------------------------
-- Company: USAF Academy
-- Engineer: C2C John Miller
-- 
-- Create Date:    15:32:14 02/03/2014 
-- Design Name: 
-- Module Name:    pixel_gen - Behavioral 
-- Project Name:   Atlys Video - Lab1
-- Target Devices: 
-- Tool versions: 
-- Description: Code to generate pixel pattern for the top shell
--	
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity pixel_gen is
    Port ( row : in unsigned (10 downto 0);
           column : in  unsigned (10 downto 0);
           blank : in  STD_LOGIC;
			  switch_6 : in std_logic;
			  switch_7 : in std_logic;
           r : out  std_logic_vector (7 downto 0);
           g : out  std_logic_vector (7 downto 0);
           b : out  std_logic_vector (7 downto 0)
			  );
end pixel_gen;

architecture Behavioral of pixel_gen is

--block of code I'm considering implementing, it may make code more readable
--type color_type is
--(black, red, blue, green, yellow, white);
--signal color_result: color_type;

begin

process(blank, row, column)
begin 
	r <= ( others=>'0');
	g <= ( others=>'0');
	b <= ( others=>'0');
	
	if (blank = '1') then
	r <= ( others=>'0');
	g <= ( others=>'0');
	b <= ( others=>'0');

--I very much guessed the RGB values here, I was just looking for 4 distinct patterns
	elsif(switch_6 = '0' and switch_7 = '0') then
	-- bottom third of the screen
					if ( row > 320)  then
							r <= ( others=>'1');
							g <=(others => '1');
							b <= (others => '0');
	-- left third of screen						
					elsif(column < 214) then
							r <= ( others=>'1');
							g <= ( others=>'0');
							b <= (others => '0');
	-- middle third of screen						
					elsif (column < 427) then
							r <= ( others=>'0');
							g <=  (others => '1');
							b <= ( others=>'0');		
	-- right third of screen						
					else 
							r <= ( others=>'0');
							g <= ( others=>'0');
							b <= (others => '1');
					end if;
	
				
		elsif(switch_6 = '0' and switch_7 = '1') then
					if ( row > 320)  then
							r <= ( others=>'0');
							g <=(others => '0');
							b <= (others => '1');
					elsif(column < 214) then
							r <= ( others=>'1');
							g <= ( others=>'1');
							b <= (others => '0');
					elsif (column < 427) then
							r <= ( others=>'0');
							g <=  (others => '0');
							b <= ( others=>'1');					
					else 
							r <= ( others=>'1');
							g <= ( others=>'0');
							b <= (others => '0');
					end if;
	
		elsif(switch_6 = '1' and switch_7 = '0') then
					if ( row > 320)  then
							r <= ( others=>'0');
							g <=(others => '1');
							b <= (others => '0');
					elsif(column < 214) then
							r <= ( others=>'1');
							g <= ( others=>'0');
							b <= (others => '0');
					elsif (column < 427) then
							r <= ( others=>'1');
							g <=  (others => '1');
							b <= ( others=>'0');					
					else 
							r <= ( others=>'0');
							g <= ( others=>'0');
							b <= (others => '1');
					end if;
				
		elsif(switch_6 = '1' and switch_7 = '1') then
					if ( row > 320)  then
							r <= ( others=>'1');
							g <=(others => '0');
							b <= (others => '1');
					elsif(column < 214) then
							r <= ( others=>'1');
							g <= ( others=>'1');
							b <= (others => '0');
					elsif (column < 427) then
							r <= ( others=>'0');
							g <=  (others => '0');
							b <= ( others=>'1');					
					else 
							r <= ( others=>'1');
							g <= ( others=>'0');
							b <= (others => '0');
					end if;
	end if; 			
end process;


end Behavioral;

