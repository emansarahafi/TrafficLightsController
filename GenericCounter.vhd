library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity GenericCounter is
	generic (MAX_COUNT: integer := 60);  -- Default max count, can be overridden
	port (clk, Clr : in std_logic;
			values : out std_logic_vector (7 downto 0));
end GenericCounter;

architecture behaviour of GenericCounter is
	component ClockDivider is
	port (clkin : in std_logic;
			clkout : out std_logic);
	end component;
	signal CNT : integer range 0 to 255;  -- Large enough for any counter
	signal clkout: std_logic;

	begin
		Clock : ClockDivider port map(clk, clkout);
		process (clk, Clr)
		begin
			if (Clr = '1') then 
				CNT <= 0;
			elsif (clkout'event and clkout = '1') then
				if (CNT >= MAX_COUNT) then 
					CNT <= 0;
				else 
					CNT <= CNT + 1;
				end if;
			end if;
		end process;
 
		values <= conv_std_logic_vector(CNT, 8);
end behaviour;
