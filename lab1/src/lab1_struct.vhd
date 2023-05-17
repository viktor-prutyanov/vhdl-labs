library IEEE;
use IEEE.std_logic_1164.all; 

architecture struct of lab1 is
	signal not_d : std_logic;
	signal b_or_c : std_logic;
    signal b_or_c_and_not_d : std_logic;
begin

    not0: entity work.lab1_not(rtl) port map(
        X => D,
        Y => not_d
    );

    or0: entity work.lab1_or(rtl) port map(
		X0 => B,
		X1 => C,
		Y => b_or_c
	);

	and0: entity work.lab1_and(rtl) port map(
		X0 => b_or_c,
        X1 => not_d,
        Y => b_or_c_and_not_d
	);

	and1: entity work.lab1_and(rtl) port map(
		X0 => A,
        X1 => b_or_c_and_not_d,
        Y => Y
	);

end struct;