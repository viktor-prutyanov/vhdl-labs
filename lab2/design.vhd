library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std_unsigned;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity arbiter is 
	generic(
    	N: integer := 8 -- Number of devices
    );
    port(
		clk: in std_logic; -- Clock
		rst: in std_logic; -- Synchronous reset
        prio: in std_logic_vector(3*N-1 downto 0); -- Static priorities, 5 levels take 3 bits, N devices takes 3*N bits
        req: in std_logic_vector(N-1 downto 0); -- Access request
        gnt: out std_logic_vector(N-1 downto 0) -- Request granted (register)
    );
end arbiter;

architecture rtl of arbiter is
	constant N_log: integer := integer(ceil(log2(real(N)))); -- Width of device index
    
    function is_all(vec : std_logic_vector; val : std_logic) return boolean is
        constant all_bits : std_logic_vector(vec'range) := (others => val);
    begin
        return vec = all_bits;
    end function;

	signal max_prio: std_logic_vector(2 downto 0); -- Maximum static priority
	signal max_prio_mask: std_logic_vector(N-1 downto 0); -- Mask with 1 at max_prio_mask

	signal new_d: std_logic_vector(N-1 downto 0); -- New N dynamic 1-bit priorities
	signal new_d0: std_logic_vector(N-1 downto 0); -- New d. p. if previous d. p. != 0 
	signal new_d1: std_logic_vector(N-1 downto 0); -- New d. p. if previous d. p. == 0 

	signal p: std_logic_vector(4*N-1 downto 0); -- Total (static + dynamic) priorities
	signal max_p: std_logic_vector(3 downto 0); -- Maximum total priority
	signal max_p_idx: std_logic_vector(N_log-1 downto 0); -- Index of maximum total priority (from 0 to N-1)
	signal max_p_mask: std_logic_vector(N-1 downto 0); -- Mask with 1 at max_p_idx (=> GNT)

	signal d: std_logic_vector(N-1 downto 0); -- Dynamic 1-bit priorities (register)
begin
	gen_p: for i in 0 to N-1 generate
		p(4*i+3 downto 4*i+1) <= prio(3*i+2 downto 3*i) when req(i) = '1' else "000";
		p(4*i) <= d(i) when req(i) = '1' else '0';
	end generate;

	maxWN: entity work.maxWN(rtl) generic map (4, N) port map(p, max_p);
	argmaxWN: entity work.argmaxWN(rtl) generic map (4, N, N_log) port map(p, max_p, max_p_idx);

	gen_max_p_mask: for i in 0 to N-1 generate -- Vector with 1 at max_p_idx
		max_p_mask(i) <= '1' when
			max_p_idx = std_logic_vector(to_unsigned(i, N_log)) and req(i) = '1'
			else '0';
	end generate;

	max_prio <= max_p(3 downto 1);

	gen_max_prio_mask: for i in 0 to N-1 generate
		max_prio_mask(i) <= '1' when prio(3*i+2 downto 3*i) = max_prio else '0';
	end generate;

	-- Flip bit at max_p_idx in d. p.
	gen_new_d0: for i in 0 to N-1 generate
		new_d0(i) <= (not d(i)) when max_p_mask(i) = '1' else d(i);
	end generate;

	-- Set 1s to d. p., except one in GNT
	new_d1 <= d or (max_prio_mask and req and not max_p_mask);
	
	new_d <= new_d0 when
	    not is_all(d and (max_prio_mask and req), '0') -- All d. p. in group are 0s
		else new_d1;

	process(clk) begin
   		if rising_edge(clk) then
        	if rst = '1' then
    			gnt <= (others => '0');
				d <= (others => '0');
			else
				gnt <= max_p_mask;
				d <= new_d;
            end if;
		end if;
	end process;
end rtl;
