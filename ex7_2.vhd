----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 11:33:07 AM
-- Design Name: 
-- Module Name: ex7_2 - Behavioral
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
entity mux4t1 is --- ENTITY
    port ( A,B, C, D : in std_logic_vector(7 downto 0);
           SEL : in std_logic_vector(1 downto 0);
           M_OUT : out std_logic_vector(7 downto 0));
end mux4t1;

architecture my_mux of mux4t1 is --- ARCHITECTURE
begin
    with SEL select
    M_OUT <= A when "11",
             B when "10",
             C when "01",
             D when others;
end my_mux;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec is --- ENTITY
    port ( D_IN : in std_logic;
           D_OUT1, D_OUT2 : out std_logic);
end dec;

architecture my_dec of dec is --- ARCHITECTURE
begin
    de: process(D_IN)
    begin
    if (D_IN = '0') then
        D_OUT1 <= '1';
        D_OUT2 <= '0';
    elsif (D_IN = '1') then
        D_OUT1 <= '0';
        D_OUT2 <= '1';
    end if;
end process;
end my_dec;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg8 is --- ENTITY
    Port ( REG_IN : in std_logic_vector(7 downto 0);
            LD,CLK : in std_logic;
            REG_OUT : out std_logic_vector(7 downto 0));
end reg8;

architecture reg8 of reg8 is --- ARCHITECTURE
begin
    reg: process(CLK)
    begin
    if (rising_edge(CLK)) then
        if (LD = '1') then
            REG_OUT <= REG_IN;
        end if;
    end if;
end process;
end reg8;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex7_2 is
  Port (X, Y, Z : in std_logic_vector(7 downto 0);
        CLK, DS : in std_logic;
        MS : in std_logic_vector(1 downto 0);
        REG_A,REG_B : out std_logic_vector(7 downto 0));
end ex7_2;

architecture Behavioral of ex7_2 is


component mux4t1
    port ( A,B, C, D : in std_logic_vector(7 downto 0);
           SEL : in std_logic_vector(1 downto 0);
           M_OUT : out std_logic_vector(7 downto 0));
end component;

component dec
    port ( D_IN : in std_logic;
           D_OUT1, D_OUT2 : out std_logic);
end component;

component reg8
    Port ( REG_IN : in std_logic_vector(7 downto 0);
            LD,CLK : in std_logic;
            REG_OUT : out std_logic_vector(7 downto 0));
end component;

signal s_mux_result, tempA, tempB : std_logic_vector(7 downto 0);
signal D0, D1 : std_logic;


begin
    ra: reg8
    port map ( REG_IN => s_mux_result,
               LD => D0,
               CLK => CLK,
               REG_OUT => tempA );
               
    rb: reg8
    port map ( REG_IN => tempA,
               LD => D1,
               CLK => CLK,
               REG_OUT => tempB );
               
    d: dec
    port map ( D_IN => DS,
               D_OUT1 => D0,
               D_OUT2 => D1 );
               
    m: mux4t1
    port map ( A => X,
               B => Y,
               C => Z,
               D => tempB,
               SEL => MS,
               M_OUT => s_mux_result );
    
REG_B <= tempB;
REG_A <= tempA;     

end Behavioral;
