library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std_unsigned;

entity max3N is
    generic(
    	N: integer := 8 -- Number of devices
    );
    port(
        prio: in std_logic_vector(3*N-1 downto 0); -- N devices takes 3*N bits
        y: out std_logic_vector(2 downto 0) -- Maximum of N 3-bit numbers
    );
end max3N;

architecture rtl of max3N is
    signal q: std_logic_vector(3*N-1 downto 0); -- Max3 inputs and outputs
begin
    q(2 downto 0) <= prio(2 downto 0);
    gen1: for i in 0 to N-2 generate
        max3_i: entity work.max3(rtl) port map(
            q((i*3+2) downto (i*3)),
            prio((i*3+5) downto (i*3+3)),
            q((i*3+5) downto (i*3+3))
        );
    end generate;
    y <= q(3*N-1 downto 3*N-3);
end rtl;
