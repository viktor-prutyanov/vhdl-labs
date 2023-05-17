library IEEE;
use IEEE.std_logic_1164.all;

entity lab1_not is
port(
  X: in std_logic;
    Y: out std_logic);
    end lab1_not;
    
    architecture rtl of lab1_not is
    begin
	Y <= not X;
	end rtl;