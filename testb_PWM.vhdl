LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.Package_PWM.all;
use ieee.std_logic_unsigned.all;

ENTITY testb_PWM IS
END testb_PWM;

ARCHITECTURE arq OF testb_PWM IS 
	-- Declaração do componente
	COMPONENT PWM
		PORT(
            CLK : in  STD_LOGIC;
            DUTY : in  STD_LOGIC_VECTOR ((pwm_bit - 1) downto 0);
            reset : in std_logic;
            PWM_OUT : out  STD_LOGIC
		);
	END COMPONENT;
	-- Entradas
	
	signal reset : std_logic := '0';
	signal duty : std_logic_vector((pwm_bit - 1) downto 0) := (others => '0');
	
	constant clk_period : time := 20 us;
    signal clk : std_logic := '0';

BEGIN
	pwm_pr: PWM PORT MAP (
		CLK => clk,
		reset => reset,
		DUTY => duty,
		PWM_OUT => open
	);

clk_process :process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
	 
 	
 stim_proc: process
	begin		
		-- Estado de reset.
		reset <= '1';
		wait for 10 us;
		reset <= '0';
		-- Simulação.
		duty <= "00000000";      -- 0%.
		wait for clk_period * 2000;-- ciclos completos.
		duty <= "00011001";      -- 25%.
		wait for clk_period * 5000; -- ciclos completos.   
		duty <= "00110010";      -- 50%.
		wait for clk_period * 5000; -- ciclos completos.
		duty <= "01100100";      -- 100%.
		wait;
	end process;
END;