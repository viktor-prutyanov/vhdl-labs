-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library std;
use std.env.all;

entity testbench is
end testbench;

architecture tb of testbench is
	signal clk, rst: std_logic;
    signal prio: std_logic_vector(23 downto 0);
    signal req: std_logic_vector(7 downto 0);
    signal gnt: std_logic_vector(7 downto 0);
begin
	arbiter: entity work.arbiter(rtl) port map(clk, rst, prio, req, gnt);
    test_req_gen: entity work.test_req_gen(rtl) port map(clk, rst, req);

    process begin -- 100 MHz clock
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    process begin
    	rst <= '1';
     	prio <= "000001010011100001011011"; -- 0, 1, 2, 3, 4, 1, 3, 3
        --prio <= "011011011011011011011011";
        wait for 15 ns;
        rst <= '0';
        wait for 1000 ns;
        rst <= '1';
        wait for 10 ns;
        prio <= "111010101100011110100100";
        wait for 1000 ns;
        finish(0);
    end process;

end tb;
