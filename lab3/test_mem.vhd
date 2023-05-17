library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity test_mem is
generic (
    data_width : natural := 8;
    addr_width : natural := 6
);
port (
    clk : in std_logic;
    rst : in std_logic;

    addr : out natural range 0 to 2**addr_width - 1;
    data : out std_logic_vector((data_width-1) downto 0);
    we : out std_logic;
    valid_in : out std_logic;
    q : in std_logic_vector((data_width-1) downto 0);
    valid_out : in std_logic
);
end test_mem;

architecture rtl of test_mem is
    type state_t is (s0, s1, s2, s3, s4);
    signal state: state_t;
    signal cnt: natural range 0 to 2**addr_width - 1;
begin

    process(clk)
    begin
        if (rising_edge(clk)) then -- port a
            if rst = '1' then
                state <= s0;
                valid_in <= '0'; we <= '0';
                data <= (others => '0');
                cnt <= 0;
            else
                case state is
                    when s0 =>
                        state <= s1;
                    when s1 =>
                        valid_in <= '1'; addr <= cnt; data((addr_width-1) downto 0) <= std_logic_vector(to_unsigned(cnt, addr_width)); we <= '1';
                        state <= s2;
                    when s2 =>
                        valid_in <= '0'; we <= '0';
                        state <= s3 when (valid_out = '1') else s2;
                    when s3 =>
                        valid_in <= '1'; addr <= cnt; we <= '0';
                        state <= s4;
                    when s4 =>
                        valid_in <= '0';
                        if (valid_out = '1') then
                            assert q((addr_width-1) downto 0) = std_logic_vector(to_unsigned(cnt, addr_width)) report "q /= cnt" severity error;
                            cnt <= cnt when (cnt = 2**addr_width - 1) else cnt + 1;
                            state <= s0;
                        end if;
                end case;
            end if;
        end if;
    end process;
end rtl;
