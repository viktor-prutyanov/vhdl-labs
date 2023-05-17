library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std_unsigned;

entity equ3N is
    generic(
    	N: integer := 8 -- Number of devices
    );
    port(
        p: in std_logic_vector(3*N-1 downto 0);
        x: in std_logic_vector(2 downto 0);
        y: out std_logic_vector(N-1 downto 0)
    );
end equ3N;

architecture rtl of equ3N is
begin
    gen: for i in 0 to N-1 generate
        y(i) <= '1' when p(3*i+2 downto 3*i) = x else '0';
    end generate;
end rtl;
