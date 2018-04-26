
------------------------------------------------------------------------------------------
-- Title      : PWM_Package
-- Project    : PWM
------------------------------------------------------------------------------------------
-- File       : Package_PWM.vhd
-- Author     : Ricardo G. Aguiar
-- Company    : UFMT- Universidade Federal do Mato grosso - IENG 
-- Created    : 2018-04-23
------------------------------------------------------------------------------------------
-- Description: Partir desse package é possível realizar a configuração desejada 
-- para o PWM. 
-- As constant declaradas abaixo são utilizadas no PWM.vhdl and Prescaler.vhdl
-------------------------------------------------------------------------------------------
--  Constant\descrição  
--  clk_sys       : essa constant defini o clock do FPGA;
--  pwm_out       : a frequência desejada para o PWM;
--  resolucao_max : limite para o contador;
--  pwm_bit       : resolução do pwm em bits;
--  clk_pr        : representa o clock que preciso gerar para obter o clock do PWM desejado;
--  escala_aux    : escalada para obter o clock desejado;
--  escala        : como um período de clock é divido em nível High/Low, precisa dividir a
-- escala por 2.
--------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;

package Package_PWM is
    constant clk_sys : integer := 50_000_000; -- freq do meu FPGA
    constant pwm_clk : integer := 10_000;     -- freq desejada para o PWM 
    constant resolucao_max : integer := 256; --  resolução max para 8 bits  
    constant pwm_bit : integer := 8;         --  resolução em bits
    constant clk_pr : integer := (pwm_clk * resolucao_max); -- O clk que meu sistema 
                                                --precisa ter :2.56MHz, nesse exemplo
    constant escala_aux : integer := (clk_sys / clk_pr);  -- Escala : 19,53125
    constant escala : integer := (escala_aux / 2);  -- 9,765
    
end Package_PWM;  

