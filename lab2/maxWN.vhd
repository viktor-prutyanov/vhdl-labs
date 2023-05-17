library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std_unsigned;

entity maxWN is
    generic(
        W: integer; -- Width
    	N: integer -- Number of devices
    );
    port(
        x: in std_logic_vector(W*N-1 downto 0); -- N devices takes W*N bits
        y: out std_logic_vector(W-1 downto 0) -- Maximum of N W-bit numbers
    );
end maxWN;

architecture rtl of maxWN is
    signal q: std_logic_vector(W*N-1 downto 0); -- MaxW inputs and outputs
begin
    q(W-1 downto 0) <= x(W-1 downto 0);
    gen_q: for i in 0 to N-2 generate
        maxWi: entity work.maxW(rtl) generic map (W) port map(
            q((i*W+W-1) downto (i*W)),
            x((i*W+2*W-1) downto (i*W+W)),
            q((i*W+2*W-1) downto (i*W+W))
        );
    end generate;
    y <= q(W*N-1 downto W*N-W);
end rtl;
