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

process(clk,reset)
   begin
      if (reset='1') then
         state_reg <= ActiveVideo;
			count <= (others => '0');
      elsif (clk'event and clk='1') then
         count <= count_next;
			state_reg <= state_next;
      end if;
end process;

process(count)
	begin
		case state_reg is
			when ActiveVideo =>
				if (count <"1010000000") then
					state_next <= ActiveVideo;
					count_next <= count +"0000000001";	
				else
					state_next <= FrontPorch;
					count_next <= (others => '0');
				end if;
			when FrontPorch =>
				if (count<16) then
					count_next <= count +1;
					state_next <= FrontPorch;
				else 
					state_next <= Sync;
					count_next <= (others => '0');
				end if;
			when Sync =>
				if (count <96) then
					state_next <= Sync;
					count_next <= count +1;
				else
					state_next <= BackPorch;
					count_next <= (others => '0');
				end if;
			when BackPorch =>
				if (count <17) then
					state_next <= BackPorch;
					count_next <= count +1;
				else	
					state_next <= Complete;
					count_next <= (others => '0');
				end if;
			when Complete =>
				if (count <1) then
					state_next <= Complete;
					count_next <= count +1;
				else	
					state_next <= ActiveVideo;	
					count_next <= (others => '0');		
				end if;		
		end case;
	end process;

 process(state_next)
   begin
	
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

