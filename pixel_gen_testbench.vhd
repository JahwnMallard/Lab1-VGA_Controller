--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:25:30 02/04/2014
-- Design Name:   
-- Module Name:   C:/Users/C15John.Miller/Documents/Classes/2nd class/Spring/ECE383/VHDL/atlys_lab_video/pixel_gen_testbench.vhd
-- Project Name:  atlys_lab_video
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pixel_gen
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY pixel_gen_testbench IS
END pixel_gen_testbench;
 
ARCHITECTURE behavior OF pixel_gen_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pixel_gen
    PORT(
         row : IN  unsigned(10 downto 0);
         column : IN  unsigned(10 downto 0);
         blank : IN  std_logic;
         r : OUT  unsigned(7 downto 0);
         g : OUT  unsigned(7 downto 0);
         b : OUT  unsigned(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal row : unsigned(10 downto 0) := (others => '0');
   signal column : unsigned(10 downto 0) := (others => '0');
   signal blank : std_logic := '0';

 	--Outputs
   signal r : unsigned(7 downto 0);
   signal g : unsigned(7 downto 0);
   signal b : unsigned(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pixel_gen PORT MAP (
          row => row,
          column => column,
          blank => blank,
          r => r,
          g => g,
          b => b
        );

   -- Clock process definitions


   -- Stimulus process
   stim_proc: process
   begin		

blank <= '1';
wait for 1 ns;
assert ( (r = 0) and (g=0) and (b = 0 )) report "blank failed";
wait for 10 ns;
blank <= '0';
row<= (others => '0');
column <=(others => '0');
wait for 1 ns;
assert ((r = 255) and (g=0) and (b = 0 )) report "0,0  failed";
wait for 10 ns;
row<= "00000110010";
column <="00010100000";
wait for 1 ns;
assert ((r = 0) and (g=255) and (b = 0 )) report "50,160  failed";
wait for 10 ns;
row<= "00000110010";
column <="00101000000";
wait for 1 ns;
assert ((r = 0) and (g=0) and (b = 255 )) report "50,320  failed";
wait for 10 ns;
row<= "00111111111";
column <="00111100000";
wait for 1 ns;
assert ((r = 0) and (g=0) and (b = 255 )) report "511,480  failed";
wait for 10 ns;
row<= "01000000000";
column <="00101000000";
wait for 1 ns;
assert ((r = 0) and (g=255) and (b = 255 )) report "512,320  failed";
wait for 10 ns;
row<= "01010000000";
column <="00111100000";
wait for 1 ns;
assert ((r = 0) and (g=255) and (b = 255 )) report "640,480  failed";
      
		
		wait;
   end process;

END;
