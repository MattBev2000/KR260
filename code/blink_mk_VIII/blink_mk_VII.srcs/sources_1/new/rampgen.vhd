library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity rampgen is
    Port ( 
    aclk : in STD_LOGIC;
    cfg_reg : in STD_LOGIC_VECTOR (31 downto 0);
    m_axis_tdata        : out std_logic_vector(31 downto 0);
    m_axis_tvalid       : out std_logic;
    m_axis_tready       : in  std_logic;
    m_axis_tlast        : out std_logic;
    led : out STD_LOGIC);
end rampgen;

architecture implementation of rampgen is
    signal prev_reg: STD_LOGIC_VECTOR (31 downto 0);
    signal led_out: STD_LOGIC := '0';
begin
    led <= led_out;
    handle_ramp: process(aclk)
    variable out_count : integer;
    begin
        if rising_edge(aclk)  then
            if (prev_reg = "00000000000000000000000000000000" and not (cfg_reg =  "00000000000000000000000000000000")) then 
                out_count := to_integer(signed(cfg_reg(31 downto 0)));
                led_out <= '1';
            end if;
            if out_count > 0 and m_axis_tready = '1' then
                out_count := out_count - 1;
                m_axis_tdata <= std_logic_vector(to_unsigned(out_count, 32));
                m_axis_tvalid <= '1';
                m_axis_tlast <= '1';
            else
                m_axis_tvalid <= '0';
                m_axis_tlast <= '0';
            end if;
            prev_reg <= cfg_reg;
        end if;
    end process; 
end implementation;
