-- Clock Divider
-- Every match, the output signal is toogled
-- The output frequency is given by: f_out = f_in / (2*max_val)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity prescaler is

    Port ( data_in   : in STD_LOGIC;
           data_out  : out STD_LOGIC);

end prescaler;



architecture Behavioral of prescaler is
       
    constant    max_val     : integer                           := 500000;  -- CHANGE HERE the value to have the desired output frequency
    signal      counter     : integer range 0 to max_val-1      := 0; -- Start value of the counter, DO NOT CHANGE
    signal      tmp         : std_logic                         := '1';  -- Start value of clk_out, change if necessary
    
begin

    process(data_in)
    begin
        if rising_edge(data_in)
        then
            if counter = max_val-1  -- Counts from 0 to max_val-1
            then
                counter <= 0;
                tmp <= not tmp;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    data_out <= tmp;

end Behavioral;
