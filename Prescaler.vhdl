
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Package_PWM.all;

entity Prescaler is
    
    Port (
        clk_in : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        clk_out : out STD_LOGIC
    );
end Prescaler;
 
architecture Behavioral of Prescaler is
    signal clk_aux: STD_LOGIC;
    signal contador: integer := 0;
begin
   
    div : process (reset, clk_in) 
    begin
        if (reset = '1') then
            clk_aux <= '0';
            contador <= 0;
        elsif rising_edge(clk_in) then
            if (contador = (escala - 1)) then
                clk_aux <= NOT(clk_aux);
                contador <= 0;
            else
                contador <= contador + 1;
            end if;
        end if;
    end process;
     
    clk_out <= clk_aux;
end Behavioral;