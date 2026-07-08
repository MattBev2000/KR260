-- Clock Divider
-- Every match, the output signal is toggled
-- The output frequency is given by: f_out = f_in / (2 * max_val)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity prescaler is
    Port (
        clk_in  : in STD_LOGIC;
        reset   : in STD_LOGIC;
        clk_out : out STD_LOGIC
    );
end prescaler;

architecture Behavioral of prescaler is
    constant max_val : integer := 500000;
    signal counter : integer range 0 to max_val - 1 := 0;
    signal tmp : std_logic := '1';
begin
    process(clk_in, reset)
    begin
        if reset = '0' then
            tmp <= '0';
            counter <= 0;
        else
            if rising_edge(clk_in) then
                if counter = max_val - 1 then  -- Counts from 0 to max_val - 1
                    counter <= 0;
                    tmp <= not tmp;
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;

    clk_out <= tmp;
end Behavioral;