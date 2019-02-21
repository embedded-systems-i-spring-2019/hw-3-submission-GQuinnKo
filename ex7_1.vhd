----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 11:19:08 AM
-- Design Name: 
-- Module Name: ex7_1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ex7_1 is
  port (D1_IN,D2_IN : in std_logic_vector(7 downto 0);
        CLK,SEL : in std_logic;
        LD : in std_logic;
        REG : out std_logic_vector(7 downto 0));
end ex7_1;

architecture Behavioral of ex7_1 is
    signal s_mux_result : std_logic_vector(7 downto 0);
begin
    r: process(CLK) -- process
    begin
    if (rising_edge(CLK)) then
        if (LD = '1') then
            REG <= s_mux_result;
        end if;
    end if;
    end process;
    
    
    with SEL select
    s_mux_result <= D1_IN when '1',
    D2_IN when '0',
    (others => '0') when others;

end Behavioral;
