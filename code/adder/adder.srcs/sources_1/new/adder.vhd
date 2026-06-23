library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.ALL;


entity adder is
    Port ( a, b : in std_logic_vector (31 downto 0);
           a_clk : in std_logic;
           ya : out std_logic_vector (31 downto 0);
           ready : out std_logic);
end adder;


architecture Behavioral of adder is
begin

    process(a_clk)
    begin
    
        if rising_edge(a_clk)
        then
        
            ya <= std_logic_vector(signed(a) + signed(b));
            ready <= '1';
            
        end if;
    
    end process;
    
    ready <= '0';

end Behavioral;
