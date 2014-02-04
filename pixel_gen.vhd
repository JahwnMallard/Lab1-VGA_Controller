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
           b : out  unsigned (7 downto 0));
end pixel_gen;

architecture Behavioral of pixel_gen is

type color_type is
(black, red, blue, green, yellow, white);

signal color_result: color_type;
begin


process(blank)
	begin 
	color_result <= black;
	
	if(blank = '1') then
		color_result <= black;
	else 
		color_result <=red;
	end if;
end process;

process(color_result)
begin 
	r <= 0;
	g <= 0;
	b <= 0;
	
	case color_result is
		when red =>
			r <= 255;
			g <= 0;
			b <= 0;
		when green =>
			r <= 0;
			g <= 255;
			b <= 0;
		when blue =>
			r <=0;
			g <=0;
			b <=255;
		when black =>
			r <= 0;
			g <= 0;
			b <= 0;
		when white =>
			r <= 255;
			g <= 255;
			b <= 255;
		when yellow =>
			r <= 0;
			g <= 255;
			b <= 255;
		end case;
 end process;

end Behavioral;

