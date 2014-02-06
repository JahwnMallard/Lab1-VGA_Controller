--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:48:43 01/29/2014
-- Design Name:   
-- Module Name:   C:/Users/C15John.Miller/Documents/Classes/2nd class/Spring/ECE383/VHDL/atlys_lab_video/H_sync_testbench.vhd
-- Project Name:  atlys_lab_video
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: h_sync_gen
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
 
ENTITY H_sync_testbench IS
END H_sync_testbench;
 
ARCHITECTURE behavior OF H_sync_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT h_sync_gen
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         h_sync : OUT  std_logic;
         blank : OUT  std_logic;
         completed : OUT  std_logic;
         column : OUT  unsigned(10 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal h_sync : std_logic;
   signal blank : std_logic;
   signal completed : std_logic;
   signal column : unsigned(10 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: h_sync_gen PORT MAP (
          clk => clk,
          reset => reset,
          h_sync => h_sync,
          blank => blank,
          completed => completed,
          column => column
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
	   wait for 5 ns;	
		assert (h_sync = '1') report "init not working - h_sync";
		assert (blank = '0') report "init not working - blank";
		assert (completed = '0') report "init not working - completed";
		assert (column = 1) report "init not working - column";
  
		reset <= '0';


      wait for clk_period*1;
		assert (h_sync = '1') report "active video not working - h_sync";
		assert (blank = '0') report "active video not working - blank";
		assert (completed = '0') report "active video not working - completed";
		assert (column = 2) report "active video not working - column";
		
		wait for clk_period*637;
		assert (h_sync = '1') report "active video not working - h_sync";
		assert (blank = '0') report "active video not working - blank";
		assert (completed = '0') report "active video not working - completed";
		assert (column = 639) report "active video not working - column";
		
      wait;
   end process;

END;
