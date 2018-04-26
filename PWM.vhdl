library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
use ieee.std_logic_arith.ALL;
use work.Package_PWM.all;


entity PWM is
	
	Port ( clk : in  STD_LOGIC;
		   duty : in  STD_LOGIC_VECTOR ((pwm_bit - 1) downto 0);
		   reset : in std_logic;
           PWM_out : out  STD_LOGIC);
end PWM;
	
architecture Behavioral of PWM is

	signal counter : std_logic_vector ((pwm_bit - 1) downto 0) := (others => '0');
	signal clk_out : std_logic;

	component Prescaler 
		
		Port (
			clk_in : in  STD_LOGIC;
			reset  : in  STD_LOGIC;
			clk_out : out STD_LOGIC	
		);
	end component;

begin
	
	presc : Prescaler port map (clk, reset, clk_out);

	process (clk_out)
	begin
		if reset = '1' then
	           counter <= (others => '0');
		   PWM_out <= '0';
		elsif rising_edge(clk_out) then
			if counter = (resolucao_max - 1) then
				counter <= (others => '0');
			else
				counter <= counter + '1';
			end if;
			if counter > duty then
				PWM_out <= '0';
			elsif duty /= 0 then
				PWM_out <= '1';
			end if;
		end if;
	end process;

end Behavioral;