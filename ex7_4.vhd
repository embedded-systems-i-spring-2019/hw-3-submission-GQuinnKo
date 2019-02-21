----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 02:40:26 PM
-- Design Name: 
-- Module Name: ex7_4 - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux2t1 is --- ENTITY
    port ( A,B : in std_logic_vector(7 downto 0);
           SEL : in std_logic;
           M_OUT : out std_logic_vector(7 downto 0));
end mux2t1;

architecture my_mux of mux2t1 is --- ARCHITECTURE
begin
    with SEL select
        M_OUT <= A when '1',
                 B when '0',
                 (others => '0') when others;
end my_mux;

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

entity and_gate is
    port ( A,B : in std_logic;
           F : out std_logic);
end and_gate;

architecture my_gate of and_gate is --- ARCHITECTURE
begin
    F <= A AND B;
end my_gate;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ex7_4 is
    port (x, Y : in std_logic_vector(7 downto 0);
          CLK,S1, S0 : in std_logic;
          LDA, LDB,RD : in std_logic;
          REG_B, Reg_A : out std_logic_vector(7 downto 0));
end ex7_4;

architecture Behavioral of ex7_4 is

component mux2t1
    port ( A,B : in std_logic_vector(7 downto 0);
           SEL : in std_logic;
           M_OUT : out std_logic_vector(7 downto 0));
end component;

component reg8
    Port ( REG_IN : in std_logic_vector(7 downto 0);
           LD,CLK : in std_logic;
           REG_OUT : out std_logic_vector(7 downto 0));
end component;

component and_gate is
    port ( A,B : in std_logic;
           F : out std_logic);
end component;

signal mux_result_1, mux_result_2 : std_logic_vector(7 downto 0);
signal tempB : std_logic_vector(7 downto 0);
signal AND1, AND2, NOTRD : std_logic;

begin
    ra: reg8
    port map ( REG_IN => mux_result_2,
               LD => AND1,
               CLK => CLK,
               REG_OUT => Reg_A );
    rb: reg8
    port map ( REG_IN => mux_result_1,
               LD => AND2,
               CLK => CLK,
               REG_OUT => tempB );
    m1: mux2t1
    port map ( A => X,
               B => Y,
               SEL => S1,
               M_OUT => mux_result_1);
    m2: mux2t1
    port map ( A => tempB,
               B => Y,
               SEL => S0,
               M_OUT => mux_result_2);
    
    a1: and_gate
    port map ( A => LDA,
               B => RD,
               F => AND1 );
               
    a2: and_gate
    port map ( A => LDB,
              B => NOTRD,
              F => AND2 );


REG_B <= tempB;
NOTRD <= NOT RD;
end Behavioral;