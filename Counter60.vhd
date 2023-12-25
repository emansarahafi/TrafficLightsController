library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Counter60 is
	generic (N: integer range 0 to 60 := 60);
	port (clk, Clr : in std_logic;
			values : out std_logic_vector (7 downto 0));
end Counter60;

architecture behaviour of Counter60 is
	component Experiment05PartA is
	port (clkin : in std_logic;
			clkout : out std_logic);
	end component;
	signal CNT : integer range 0 to 60;
	signal clkout: std_logic;

	begin
		Clock : Experiment05PartA port map(clk, clkout);
		process (clk, Clr)
		begin
			if (Clr = '1') then CNT <= 0;
				elsif (clkout'event and clkout = '1') then
						if (CNT = N-1) then CNT <= CNT + 1;
						elsif (CNT = N) then CNT <= 0;
						else CNT <= CNT + 1;
						end if;
			end if;
 end process;
 
values <= conv_std_logic_vector(CNT,8);
end behaviour;