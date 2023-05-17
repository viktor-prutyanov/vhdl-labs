library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std_unsigned;

entity maxW is
    generic(
        W: integer -- Width
    );
    port(
        x0: in std_logic_vector(W-1 downto 0);
        x1: in std_logic_vector(W-1 downto 0);
        y: out std_logic_vector(W-1 downto 0)
    );
end maxW;

architecture rtl of maxW is
begin
    y <= x0 when x0 > x1 else x1;
end rtl;
