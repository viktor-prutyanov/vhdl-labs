library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity test_req_gen is 
	generic(
    	N: integer := 8 -- Number of devices
    );
    port(
		clk: in std_logic; -- Clock
		rst: in std_logic; -- Synchronous reset
        req: out std_logic_vector(N-1 downto 0) -- Access request
    );
end test_req_gen;

architecture rtl of test_req_gen is
    signal state: integer;
begin
    process(clk) begin
        if rising_edge(clk) then
            if rst = '1' then
               -- state <= 0;
               req <= "00000000";
            else
                --state <= state + 1;
                req <= req + "00000001";
            end if;
        end if;
    end process;

  --  process(all) begin
        --case state is
            -- when 0 => req <= "11111111"; 
            -- when 1 => req <= "11110111";
            -- when 2 => req <= "11100111";
            -- when 3 => req <= "11100101";
            -- when 4 => req <= "11100100";
            -- when 5 => req <= "11000100";
            -- when 6 => req <= "10000100";
            -- when 7 => req <= "10000000";
            -- when 8 => req <= "00000000";
            -- when others => req <= "00010011";
            -- when others => req <= "11111111";
            -- when others => req <= "11100000";
        --end case;
		
	
end rtl;