library IEEE;
use IEEE.std_logic_1164.all;

library std;
use std.env.all;

entity testbench is
end testbench;

architecture tb of testbench is
	signal clk, rst: std_logic;

    signal addr_a : natural range 0 to 2**6 - 1;
    signal data_a : std_logic_vector(7 downto 0);
    signal we_a : std_logic;
    signal valid_in_a : std_logic;
    signal q_a : std_logic_vector(7 downto 0);
    signal valid_out_a : std_logic;

    signal addr_b : natural range 0 to 2**6 - 1;
    signal data_b : std_logic_vector(7 downto 0);
    signal we_b : std_logic;
    signal valid_in_b : std_logic;
    signal q_b : std_logic_vector(7 downto 0);
    signal valid_out_b : std_logic;
begin
    memory: entity work.memory(rtl) port map(clk, rst,
        addr_a, data_a, we_a, valid_in_a, q_a, valid_out_a,
        addr_b, data_b, we_b, valid_in_b, q_b, valid_out_b
    );
    test_mem_a: entity work.test_mem(rtl) port map(clk, rst,
        addr_a, data_a, we_a, valid_in_a, q_a, valid_out_a
    );
    test_mem_b: entity work.test_mem(rtl) port map(clk, rst,
        addr_b, data_b, we_b, valid_in_b, q_b, valid_out_b
    );

    process begin -- 100 MHz clock
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    process begin
    	rst <= '1';
        wait for 15 ns;
        rst <= '0';
        wait for 6000 ns;
        finish(0);
    end process;

end tb;