----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:32:14 02/03/2014 
-- Design Name: 
-- Module Name:    pixel_gen - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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
           r : out  unsigned (7 downto 0);
           g : out  unsigned (7 downto 0);
           b : out  unsigned (7 downto 0)
			  );
end pixel_gen;

architecture Behavioral of pixel_gen is

type color_type is
(black, red, blue, green, yellow, white);
signal color_result: color_type;

begin

process(blank, row, column)
begin 
	color_result <= black;
	
	if(blank = '1') then
		color_result <= black;
	elsif ( row > 511) then
		color_result <= yellow;
	elsif(column < 160) then
		color_result <=red;
	elsif (column < 320) then
		color_result <=green;		
	else 
		color_result <=blue;
	end if; 
				
end process;

process(color_result)
begin 
	r <= ( others=>'0');
	g <= ( others=>'0');
	b <= ( others=>'0');
	
	case color_result is
		when red =>
			r <= "11111111";
			g <= ( others=>'0');
			b <= ( others=>'0');
		when green =>
			r <= ( others=>'0');
			g <= "11111111";
			b <= ( others=>'0');
		when blue =>
			r <=( others=>'0');
			g <=( others=>'0');
			b <="11111111";
		when black =>
			r <= ( others=>'0');
			g <= ( others=>'0');
			b <= ( others=>'0');
		when white =>
			r <= "11111111";
			g <= "11111111";
			b <= "11111111";
		when yellow =>
			r <= ( others=>'0');
			g <= "11111111";
			b <= "11111111";
		end case;
 end process;

end Behavioral;

