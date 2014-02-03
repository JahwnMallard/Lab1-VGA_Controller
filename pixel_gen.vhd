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

begin


end Behavioral;

