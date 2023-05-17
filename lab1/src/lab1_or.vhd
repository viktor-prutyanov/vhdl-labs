library IEEE;
use IEEE.std_logic_1164.all;

entity lab1_or is
port(
  X0: in std_logic;
  X1: in std_logic;
  Y: out std_logic);
end lab1_or;

architecture rtl of lab1_or is
begin
	Y <= X0 or X1;
end rtl;