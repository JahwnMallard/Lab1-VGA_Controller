--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:19:52 01/31/2014
-- Design Name:   
-- Module Name:   C:/Users/C15John.Miller/Documents/Classes/2nd class/Spring/ECE383/VHDL/atlys_lab_video/V_sync_testbench.vhd
-- Project Name:  atlys_lab_video
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: v_sync_gen
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
 
ENTITY V_sync_testbench IS
END V_sync_testbench;
 
ARCHITECTURE behavior OF V_sync_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT v_sync_gen
    Port ( clk         : in  std_logic;
			  reset       : in std_logic;
           h_blank     : in std_logic;
           h_completed : in std_logic;
           v_sync      : out std_logic;
           blank       : out std_logic;
           completed   : out std_logic;
           row         : out unsigned(10 downto 0)
     );
    END COMPONENT;
    
COMPONENT h_sync_gen
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;          
		h_sync : OUT std_logic;
		blank : OUT std_logic;
		completed : OUT std_logic;
		column : OUT unsigned(10 downto 0)
		);
	END COMPONENT;		
   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal h_blank : std_logic := '0';
   signal h_completed : std_logic := '0';

 	--Outputs
   signal v_sync : std_logic;
   signal blank : std_logic;
   signal completed : std_logic;
   signal row : unsigned(10 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: v_sync_gen PORT MAP (
          clk => clk,
          reset => reset,
          h_blank => h_blank,
          h_completed => h_completed,
          v_sync => v_sync,
          blank => blank,
          completed => completed,
          row => row
        );
Inst_h_sync_gen: h_sync_gen PORT MAP(
		clk => clk,
		reset => reset,
		h_sync => open,
		blank => h_blank,
		completed => h_completed,
		column => open
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
		assert (v_sync = '1') report "init not working - h_sync";
		assert (blank = '0') report "init not working - blank";
		assert (completed = '0') report "init not working - completed";
		assert (row = 0) report "init not working - column";
  
		reset <= '0';
		
      wait for 1 ns;
		assert (v_sync = '1') report "active video not working - h_sync";
		assert (blank = '0') report "active video not working - blank";
		assert (completed = '0') report "active video not working - completed";
		assert (row = 1) report "active video not working - column";
		
		wait for clk_period*799;
		assert (v_sync = '1') report "active video not working - h_sync";
		assert (blank = '0') report "active video not working - blank";
		assert (completed = '0') report "active video not working - completed";
		assert (row = 1) report "active video not working - column";
		
      wait;
   end process;

END;
