library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Experiment05PartA is
port (clkin : in std_logic;
		clkout : out std_logic);
end Experiment05PartA;

architecture behavioural of Experiment05PartA is
signal count : integer := 0;
signal clk : std_logic := '0';
begin
	process(clkin)
		begin
			if clkin'event and clkin = '1' then
				if (count = 25000000) then
				count <= 0; clk <= not clk; clkout <= clk;
				else count <= count + 1;
				end if;
			end if;
		end process;
end behavioural;