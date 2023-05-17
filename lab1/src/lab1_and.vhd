library IEEE;
use IEEE.std_logic_1164.all;

entity lab1_and is
port(
  X0: in std_logic;
  X1: in std_logic;
  Y: out std_logic);
end lab1_and;

architecture rtl of lab1_and is
begin
	Y <= X0 and X1;
end rtl;