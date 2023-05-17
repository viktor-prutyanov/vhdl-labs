library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end testbench; 

architecture tb of testbench is
	signal A, B, C, D, Y0, Y1: std_logic;
begin

    -- Behavioral model instance
	lab1_beh: entity work.lab1(beh) port map(A, B, C, D, Y0);
    -- Structural model instance
	lab1_struct: entity work.lab1(struct) port map(A, B, C, D, Y1);

	process
    begin
    	A <= '0'; B <= '0'; C <= '0'; D <= '0'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
    	A <= '0'; B <= '0'; C <= '0'; D <= '1'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
    	A <= '0'; B <= '0'; C <= '1'; D <= '0'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
    	A <= '0'; B <= '0'; C <= '1'; D <= '1'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
    	A <= '0'; B <= '1'; C <= '0'; D <= '0'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
    	A <= '0'; B <= '1'; C <= '0'; D <= '1'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
    	A <= '0'; B <= '1'; C <= '1'; D <= '0'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
    	A <= '0'; B <= '1'; C <= '1'; D <= '1'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
    	A <= '1'; B <= '0'; C <= '0'; D <= '0'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
    	A <= '1'; B <= '0'; C <= '0'; D <= '1'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
    	A <= '1'; B <= '0'; C <= '1'; D <= '0'; wait for 1 ns; assert(Y0 = '1' and Y0 = Y1) report "FAIL" severity error;
    	A <= '1'; B <= '0'; C <= '1'; D <= '1'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
    	A <= '1'; B <= '1'; C <= '0'; D <= '0'; wait for 1 ns; assert(Y0 = '1' and Y0 = Y1) report "FAIL" severity error;
    	A <= '1'; B <= '1'; C <= '0'; D <= '1'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
    	A <= '1'; B <= '1'; C <= '1'; D <= '0'; wait for 1 ns; assert(Y0 = '1' and Y0 = Y1) report "FAIL" severity error;
    	A <= '1'; B <= '1'; C <= '1'; D <= '1'; wait for 1 ns; assert(Y0 = '0' and Y0 = Y1) report "FAIL" severity error;
	A <= '0'; B <= '0'; C <= '0'; D <= '0';

    assert false report "TEST DONE" severity note;
    wait;
  end process;

end tb;
