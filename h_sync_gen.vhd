----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:19:48 01/29/2014 
-- Design Name: 
-- Module Name:    h_sync_gen - Behavioral 
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

entity h_sync_gen is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           h_sync : out  STD_LOGIC;
           blank : out  STD_LOGIC;
           completed : out  STD_LOGIC;
           column : out  unsigned (10 downto 0));
end h_sync_gen;



architecture Behavioral of h_sync_gen is

signal count, count_next : unsigned (10 downto 0);

type h_sync_type is
(ActiveVideo, FrontPorch, BackPorch, Sync, Complete);

signal state_reg, state_next : h_sync_type;
begin

process(clk, reset)
   begin
      if (reset='1') then
         state_reg <= ActiveVideo;
      elsif (clk'event and clk='1') then
			state_reg <= state_next;
      end if;
end process;


process(clk,reset)
   begin
      if (reset='1') then
			count <= (others => '0');
      elsif rising_edge(clk) then
         count <= count_next;
      end if;
end process;



--next state logic
process(count, state_reg)
	begin
		
		state_next <= state_reg;
	
		case state_reg is
			when ActiveVideo =>
				if (count = 640) then
					state_next <= FrontPorch;
				end if;
			when FrontPorch =>
				if (count = 16) then
					state_next <= Sync;
				end if;
			when Sync =>
				if (count = 96) then
					state_next <= BackPorch;
				end if;
			when BackPorch =>
				if (count = 17) then
					state_next <= Complete;
				end if;
			when Complete =>
				state_next <= ActiveVideo;	
		end case;
	end process;

--count_next logic
count_next <= (others => '0') when (state_reg /= state_next) else
					count +1;

--output logic

 process(state_next, count)
	
   begin
		h_sync <= '0';
		blank <='0';
		completed <='0';
		column <= (others => '0');
       
      case state_next is
         when ActiveVideo =>
            h_sync <= '1';
				blank <='0';
				completed <='0';
				column <= count;
         when FrontPorch =>
            h_sync <= '1';
				blank <='1';
				completed <='0';
				column <= (others => '0');
         when Sync =>
            h_sync <= '0';
				blank <='1';
				completed <='0';
				column <= (others => '0');
         when BackPorch =>
            h_sync <= '1';
				blank <='1';
				completed <='0';
				column <= (others => '0');
			when Complete =>
			   h_sync <= '1';
				blank <='1';
				completed <='1';
				column <= (others => '0');
      end case;
   end process;
			  
end Behavioral;

