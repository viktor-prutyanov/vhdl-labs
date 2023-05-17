library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std_unsigned;
use ieee.numeric_std.all;

entity argmaxWN is
    generic(
        W: integer; -- Width
    	N: integer; -- Number of elements
        N_log: integer -- Log2(N)
    );
    port(
        x: in std_logic_vector(W*N-1 downto 0); -- N elements takes W*N bits
        max: in std_logic_vector(W-1 downto 0); -- Maximum of N W-bit numbers
        argmax: out std_logic_vector(N_log-1 downto 0)
    );
end argmaxWN;

architecture rtl of argmaxWN is
    signal q: std_logic_vector(N*N_log-1 downto 0); -- Indexes of max
begin
    gen_q: for i in 0 to N-1 generate
        q((i*N_log+N_log-1) downto (i*N_log)) <=
            std_logic_vector(to_unsigned(i, N_log)) when x((i*W+W-1) downto (i*W)) = max else (others => '0');
    end generate;

    maxWN: entity work.maxWN(rtl) generic map (N_log, N) port map(q, argmax);
end rtl;
