library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std_unsigned;

entity ena3N is
    generic(
    	N: integer := 8 -- Number of devices
    );
    port(
        p: in std_logic_vector(3*N-1 downto 0); -- N devices takes 3*N bits
        ena: in std_logic_vector(N-1 downto 0); -- Maximum of N 3-bit numbers
        y: out std_logic_vector(3*N-1 downto 0)
    );
end ena3N;

architecture rtl of ena3N is
begin
    gen: for i in 0 to N-1 generate
        y(3*i+2 downto 3*i) <= p(3*i+2 downto 3*i) when ena(i) = '1' else "000";
    end generate;
end rtl;
