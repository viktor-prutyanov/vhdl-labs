library ieee;
use ieee.std_logic_1164.all;

entity memory is
generic (
    data_width : natural := 8;
    addr_width : natural := 6
);
port (
    clk : in std_logic;
    rst: in std_logic;

    addr_a : in natural range 0 to 2**addr_width - 1;
    data_a : in std_logic_vector((data_width-1) downto 0);
    we_a : in std_logic;
    valid_in_a : in std_logic;
    q_a : out std_logic_vector((data_width -1) downto 0);
    valid_out_a : out std_logic;

    addr_b : in natural range 0 to 2**addr_width - 1;
    data_b : in std_logic_vector((data_width-1) downto 0);
    we_b : in std_logic;
    valid_in_b : in std_logic;
    q_b : out std_logic_vector((data_width -1) downto 0);
    valid_out_b : out std_logic
);
end memory;

architecture rtl of memory is
    type state_t is (s0, s1, s2);
    -- build a 2-d array type for the ram
    subtype word_t is std_logic_vector((data_width-1) downto 0);
    type memory_t is array((2**addr_width - 1) downto 0) of word_t;
    -- declare the ram signal
    
    signal ram : memory_t;

    signal state_a: state_t;
    signal addr_a_tmp : natural range 0 to 2**addr_width - 1;
    signal data_a_tmp : std_logic_vector((data_width-1) downto 0);
    signal we_a_tmp : std_logic;

    signal state_b: state_t;
    signal addr_b_tmp : natural range 0 to 2**addr_width - 1;
    signal data_b_tmp : std_logic_vector((data_width-1) downto 0);
    signal we_b_tmp : std_logic;
begin
    process(clk)
    begin
        if (rising_edge(clk)) then -- port a
            if rst = '1' then
                state_a <= s0;
                valid_out_a <= '0';
            else
                case state_a is
                    when s0 =>
                        if (valid_in_a = '1') then
                            addr_a_tmp <= addr_a;
                            data_a_tmp <= data_a;
                            we_a_tmp <= we_a;
                            state_a <= s1;
                        end if;
                    when s1 =>
                        if (we_a_tmp = '1') then
                            ram(addr_a_tmp) <= data_a_tmp;
                        else
                            q_a <= ram(addr_a_tmp);
                        end if;
                        state_a <= s2;
                        valid_out_a <= '1';
                    when s2 =>
                        valid_out_a <= '0';
                        state_a <= s0;
                end case;
            end if;

            if rst = '1' then
                state_b <= s0;
                valid_out_b <= '0';
            else
                case state_b is
                    when s0 =>
                        if (valid_in_b = '1') then
                            addr_b_tmp <= addr_b;
                            data_b_tmp <= data_b;
                            we_b_tmp <= we_b;
                            state_b <= s1;
                        end if;
                    when s1 =>
                        if (we_b_tmp = '1') then
                            if (not (state_a = s1 and we_a_tmp = '1' and addr_b_tmp = addr_a_tmp)) then
                                ram(addr_b_tmp) <= data_b_tmp;
                                state_b <= s2;
                                valid_out_b <= '1';
                            end if;
                        else
                            q_b <= ram(addr_b_tmp);
                            state_b <= s2;
                            valid_out_b <= '1';
                        end if;
                    when s2 =>
                        valid_out_b <= '0';
                        state_b <= s0;
                end case;
            end if;
        end if;
    end process;
end rtl;